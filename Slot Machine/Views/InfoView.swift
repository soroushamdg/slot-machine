//
//  InfoView.swift
//  Slot Machine
//
//  Created by Soro on 2022-10-28.
//

import SwiftUI

struct InfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center,spacing: 10) {
            LogoView()
            
            Spacer()
            
            Form {
                Section(header: Text("About the application")) {
                    FormRowView(title: "Application", text: "Slot Machine")
                    FormRowView(title: "Platforms", text: "iPhone, iPad, Mac")
                    FormRowView(title: "Developer", text: "John / Jane")
                    FormRowView(title: "Designer", text: "Rober Patras")
                    FormRowView(title: "Music", text: "Dan Lebowits")
                    FormRowView(title: "Website", text: "soroush.am")
                    FormRowView(title: "Copyright 2022 All rights reserved.", text: "Slot Machine")

                }
            }
            .font(.system(.body,design: .rounded))
        }
        .padding(.top,40)
        .overlay(
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
            }
                )
            .padding(.top,30)
            .padding(.trailing,20)
            .accentColor(.secondary)
            ,alignment: .topTrailing
            )
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

struct FormRowView: View {
    var title : String
    var text : String
    var body: some View {
        HStack {
            Text(title).foregroundColor(.gray)
            Spacer()
            Text(text)
        }
    }
}
