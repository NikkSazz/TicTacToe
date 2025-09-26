//
//  ContentView.swift
//  TicTacToe
//
//  Created by Dmitry Sazonov on 9/26/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack(spacing: 20){
                Image(systemName: "xmark")
                Image(systemName: "circle")
            }
            .imageScale(.large)
            
            Text("Tic Tac Toe!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
