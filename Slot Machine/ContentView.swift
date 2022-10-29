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
    
    
    // functions
    
    func spinReels(){
        reels[0] = Int.random(in: 0...symbols.count - 1)
        reels[1] = Int.random(in: 0...symbols.count - 1)
        reels[2] = Int.random(in: 0...symbols.count - 1)
    }
    
    // check winning
    
    // player wins
    
    // new high score
    
    // player loses
    
    // game is over
    
    
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
                            
                            Text("100")
                                .scoreNumberStyle()
                                .modifier(ScoreNumberModifier())
                                
                        }
                        .modifier(ScoreContainerModifier())
                        
                        Spacer()
                        
                        HStack{
                            
                            Text("200")
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
                        }
                        
                        HStack(alignment: .center,spacing: 0) {
                            // reel 2
                            ZStack{
                                RealView()
                                Image(symbols[reels[1]])
                                    .resizable()
                                    .modifier(ImageModifier())
                            }
                            
                            Spacer()
                            // reel 3
                            ZStack{
                                RealView()
                                Image(symbols[reels[2]])
                                    .resizable()
                                    .modifier(ImageModifier())
                            }
                        }
                        .frame(maxWidth: 500)
                        // reel #2
                        
                        // spin button
                        Button {
                            spinReels()
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
                                print("Bet 20 coins")
                            } label: {
                                Text("20")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                    .modifier(BetNumberModifier())
                            }
                            .modifier(BetCapsuleModifier())
                        
                            
                            Image("gfx-casino-chips")
                                .resizable()
                                .opacity(0)
                                .modifier(CasinoChipsModifier())
                        }
                        
                        HStack(alignment: .center,spacing: 10)  {
                            
                        
                            
                            Image("gfx-casino-chips")
                                .resizable()
                                .opacity(1)
                                .modifier(CasinoChipsModifier())
                            
                            Button {
                                print("Bet 10 coins")
                            } label: {
                                Text("10")
                                    .fontWeight(.heavy)
                                    .foregroundColor(.yellow)
                                    .modifier(BetNumberModifier())
                            }
                            .modifier(BetCapsuleModifier())
                        }

                    }
                    
                }
                .overlay(
                    Button(action: {
                        print("Reset the game")
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


