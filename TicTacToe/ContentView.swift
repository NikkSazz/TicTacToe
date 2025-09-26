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
            
            Board()
        }
        .padding()
    }
}

struct Board: View {
    let spacing: CGFloat = 10
    
    @State var tapped = Array(repeating: Array(repeating: false, count: 3), count: 3)
    
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(0..<3) { row in
                
                HStack(spacing: spacing) {
                    ForEach(0..<3) { col in
                        Rectangle()
                            .fill(/* tapped[row][col] ? Color.blue : */ Color.gray.opacity(0.2))
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                withAnimation {
                                    tapped[row][col].toggle()
                                }
                            }
                            .overlay(
                                Image(systemName: tapped[row][col] ? "xmark" : "circle")
                                    .font(.largeTitle)
                                    .bold()
                            )
                            .cornerRadius(8)
                            .shadow(radius: 2)
                    }
                }
                
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
