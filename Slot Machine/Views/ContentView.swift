//
//  ContentView.swift
//  Slot Machine
//
//  Created by Soro on 2022-10-28.
//

import SwiftUI

struct ContentView: View {
    
    let symbols = ["gfx-bell","gfx-cherry","gfx-coin","gfx-grape","gfx-seven","gfx-strawberry"]
    
    @State private var reels : Array = [0,1,2]
    @State private var showingInfoView: Bool = false
    
    @State private var highscore: Int = UserDefaults.standard.integer(forKey: "highscore")
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    
    @State private var showingModal: Bool = false
    @State private var animatingSymbol: Bool = false
    
    @State private var animatingModal : Bool = false
    
    // functions
    
    func spinReels(){
//        reels[0] = Int.random(in: 0...symbols.count - 1)
//        reels[1] = Int.random(in: 0...symbols.count - 1)
//        reels[2] = Int.random(in: 0...symbols.count - 1)
        reels = reels.map({_ in
            Int.random(in: 0...symbols.count - 1)
        })
        playSound(sound: "spin", type: "mp3")
    }
    
    func checkWinning(){
        if reels.allSatisfy({ $0 == reels.first }) {
            playerWins()
            if coins > highscore {
                newHighscore()
            }else{
                playSound(sound: "win", type: "mp3")
            }
        }else{
            playerLoses()
        }
    }
    
    func playerWins(){
        coins += betAmount * 10
    }
    
    func newHighscore(){
        highscore = coins
        UserDefaults.standard.set(highscore, forKey: "highscore")
        playSound(sound: "high-score", type: "mp3")
    }
    
    func playerLoses(){
        coins -= betAmount
    }
    
    func activateBet20(){
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
        playSound(sound: "casino-chips", type: "mp3")
    }
    
    func activateBet10(){
        betAmount = 10
        isActiveBet20 = false
        isActiveBet10 = true
        playSound(sound: "casino-chips", type: "mp3")
    }
    
    func isGameOver(){
        if coins <= 0 {
            showingModal = true
            playSound(sound: "game-over", type: "mp3")
        }
    }
    
    func resetGame(){
        UserDefaults.standard.set(0, forKey: "highscore")
        highscore = 0
        coins = 100
        activateBet10()
        playSound(sound: "chimeup", type: "mp3")
    }
    var body: some View {
        
        VStack {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color("ColorPink"),Color("ColorPurple")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack(alignment: .center,spacing: 5) {
                   LogoView()
                    
                    Spacer()
                    HStack{
                        HStack{
                            Text("Your\nCoins".uppercased())
                                .scoreLabelStyle()
                                .multilineTextAlignment(.trailing)
                            
                            Text("\(coins)")
                                .scoreNumberStyle()
                                .modifier(ScoreNumberModifier())
                                
                        }
                        .modifier(ScoreContainerModifier())
                        
                        Spacer()
                        
                        HStack{
                            Text("\(highscore)")
                                .scoreNumberStyle()
                                .modifier(ScoreNumberModifier())
                            Text("High\nScore".uppercased())
                                .scoreLabelStyle()
                                .multilineTextAlignment(.trailing)
                        }
                        .modifier(ScoreContainerModifier())
                    }
                    
                    VStack(alignment: .center,spacing: 0) {
                        // reel #1
                        ZStack{
                            RealView()
                            Image(symbols[reels[0]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.5...0.7)))
                                .onAppear(){
                                    animatingSymbol.toggle()
                                    playSound(sound: "riseup", type: "mp3")
                                }
                        }
                       
                        
                        HStack(alignment: .center,spacing: 0) {
                            // reel 2
                            ZStack{
                                RealView()
                                Image(symbols[reels[1]])
                                    .resizable()
                                    .modifier(ImageModifier())
                                    .opacity(animatingSymbol ? 1 : 0)
                                    .offset(y: animatingSymbol ? 0 : -50)
                                    .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))                                    .onAppear(){
                                        animatingSymbol.toggle()
                                    }
                            }
                            
                            
                            Spacer()
                            // reel 3
                            ZStack{
                                RealView()
                                Image(symbols[reels[2]])
                                    .resizable()
                                    .modifier(ImageModifier())
                                    .opacity(animatingSymbol ? 1 : 0)
                                    .offset(y: animatingSymbol ? 0 : -50)
                                    .animation(.easeOut(duration: Double.random(in: 0.9...1.1)))
                                    .onAppear(){
                                        animatingSymbol.toggle()
                                    }
                            }
                        }
                        .frame(maxWidth: 500)
                        // reel #2
                        
                        // spin button
                        Button {
                            // reset the animation
                            withAnimation {
                                animatingSymbol = false
                            }
                            // spin the reels
                            spinReels()
                            // re-run the animation
                            withAnimation {
                                animatingSymbol = true
                            }
                            
                            checkWinning()
                            
                            isGameOver()
                            
                        } label: {
                            Image("gfx-spin")
                                .renderingMode(.original)
                                .resizable()
                                .modifier(ImageModifier())
                        }

                        
                    }// slot machine
                    .layoutPriority(2)
                    
                    Spacer()
                    
                    HStack{
                        HStack(alignment: .center,spacing: 10)  {
                            Button {
                                activateBet20()
                            } label: {
                                Text("20")
                                    .fontWeight(.heavy)
                                    .foregroundColor(isActiveBet20 ? .yellow : .white)
                                    .modifier(BetNumberModifier())
                            }
                            .modifier(BetCapsuleModifier())
                            
                                Image("gfx-casino-chips")
                                    .resizable()
                                    .offset(x: isActiveBet20 ? 0 : 20)
                                    .opacity(isActiveBet20 ? 1 : 0)
                                    .modifier(CasinoChipsModifier())
                            
                        }
                        
                        Spacer()
                        
                        HStack(alignment: .center,spacing: 10)  {
                            if isActiveBet10 {
                                Image("gfx-casino-chips")
                                    .resizable()
                                    .offset(x: isActiveBet10 ? 0 : 20)
                                    .opacity(isActiveBet10 ? 1 : 0)
                                    .modifier(CasinoChipsModifier())
                            }
                            Button {
                                activateBet10()
                            } label: {
                                Text("10")
                                    .fontWeight(.heavy)
                                    .foregroundColor(isActiveBet10 ? .yellow : .white)
                                    .modifier(BetNumberModifier())
                            }
                            .modifier(BetCapsuleModifier())
                        }

                    }
                    
                }
                .overlay(
                    Button(action: {
                        resetGame()
                    }, label: {
                        Image(systemName: "arrow.2.circlepath.circle")
                    }
                    
                )
                    .modifier(ButtonModifier())
                    ,alignment: .topLeading
                )
                .overlay(
                    Button(action: {
                        showingInfoView = true
                        print("Info View")
                    }, label: {
                        Image(systemName: "info.circle")
                    }
                    
                )
                    .modifier(ButtonModifier())
                    ,alignment: .topTrailing
                )
                .padding()
                .frame(maxWidth: 720)
                .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
                
                if $showingModal.wrappedValue {
                    ZStack {
                        Color("ColorTransparentBlack").edgesIgnoringSafeArea(.all)
                        
                        VStack(spacing: 0) {
                            Text("GAME OVER")
                                .font(.system(.title,design: .rounded))
                                .fontWeight(.heavy)
                                .padding()
                                .frame(minWidth: 0,maxWidth: .infinity)
                                .background(Color("ColorPink"))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            VStack(alignment: .center,spacing: 16) {
                                Image("gfx-seven-reel")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 72)
                                
                                Text("Bad luck! You lost all of the coins. \nLet's play again!")
                                    .font(.system(.body,design: .rounded))
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                                    .layoutPriority(1)
                                
                                Button {
                                    showingModal = false
                                    animatingModal = false
                                    activateBet10()
                                    coins = 100
                                    
                                } label: {
                                    Text("New Game".uppercased())
                                        .font(.system(.body,design: .rounded))
                                        .fontWeight(.semibold)
                                        .accentColor(Color("ColorPink"))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .frame(minWidth: 128)
                                        .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                        )
                                }

                            }
                            
                            Spacer()
                        }
                        .frame(minWidth: 280,idealWidth: 280,maxWidth: 320,minHeight: 260,idealHeight: 280,maxHeight: 320,alignment: .center)
                        .background(.white)
                        .cornerRadius(20)
                        .shadow(color: Color("ColorTransparentBlack"),radius: 6,x: 0,y: 8)
                        .opacity($animatingModal.wrappedValue ? 1 : 0)
                        .offset(y: $animatingModal.wrappedValue ? 0 : -100)
                        .animation(Animation.spring(response: 0.6,dampingFraction: 1.0,blendDuration: 1.0))
                        .onAppear(){
                            animatingModal = true
                        }
                    }
                }
            }
            .sheet(isPresented: $showingInfoView, content: {InfoView()})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


