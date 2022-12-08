//
//  ContentView.swift
//  AlpacaNote
//
//  Created by Lidiomar Fernando dos Santos Machado on 23/11/22.
//

import SwiftUI
import AlpacaNoteFramework

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(Animal().name())
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
