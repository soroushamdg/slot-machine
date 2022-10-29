//
//  ContentView.swift
//  Slot Machine
//
//  Created by Soro on 2022-10-28.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingInfoView: Bool = false
    
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
                            Image("gfx-bell")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        HStack(alignment: .center,spacing: 0) {
                            // reel 2
                            ZStack{
                                RealView()
                                Image("gfx-bell")
                                    .resizable()
                                    .modifier(ImageModifier())
                            }
                            
                            Spacer()
                            // reel 3
                            ZStack{
                                RealView()
                                Image("gfx-bell")
                                    .resizable()
                                    .modifier(ImageModifier())
                            }
                        }
                        .frame(maxWidth: 500)
                        // reel #2
                        
                        // spin button
                        Button {
                            print("SPIN THE Reels")
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


