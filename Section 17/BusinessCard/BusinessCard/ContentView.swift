//
//  ContentView.swift
//  BusinessCard
//
//  Created by Drew Dodson on 4/5/20.
//  Copyright © 2020 Arcalla.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red:0.10, green:0.74, blue:0.61, opacity: 1.00).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                
                Image("apple")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150.0, height: 150.0)
                    
                Text("John Appleseed")
                    .font(Font.custom("PTSansNarrow-Bold", size: 40))
                    .bold()
                    .foregroundColor(.white)
                Text("The Apple Man")
                    .foregroundColor(.white)
                    .font(Font.custom("PTSansNarrow-Regular", size: 20))
               Divider()
                InfoView(text: "+1 (123)456-7890", imageName: "phone.fill")
                InfoView(text: "john@apple.com", imageName: "envelope.fill")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


