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


