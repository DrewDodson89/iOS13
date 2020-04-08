//
//  ContentView.swift
//  Hacker News
//
//  Created by Drew Dodson on 4/6/20.
//  Copyright © 2020 Arcalla.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(posts) { post in
                Text(post.postTitle)
            }
        .navigationBarTitle("Hacker News")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Post: Identifiable {
    
    let id: String
    let postTitle: String
    
}


let posts = [
    Post(id: "1", postTitle: "Hello"),
    Post(id: "2", postTitle: "World")
]
