//
//  ContentView.swift
//  Slot Machine
//
//  Created by Soro on 2022-10-28.
//

import SwiftUI

struct ContentView: View {
    
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


