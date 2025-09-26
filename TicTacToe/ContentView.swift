//
//  ContentView.swift
//  TicTacToe
//
//  Created by Dmitry Sazonov on 9/26/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var board = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @State var isXTurn = true
    @State var winner: String? = nil
    
    var body: some View {
        
        ZStack{
            
            LinearGradient(
                colors: [.lightBackGround, .softLavender.opacity(0.9)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea(.all)
            
            
            VStack(spacing:20) {
                
                Text("Tic Tac Toe!")
                    .font(.largeTitle)
                    .bold()
                
                if winner != nil {
                    Text("\(winner!) Wins!")
                    
                    Button("Play Again") {
                        
                    }
                }
                
                ZStack {
                    Rectangle()
                        .foregroundStyle(.softLavender)
                        .aspectRatio(1, contentMode: .fit)
                    
                    VStack(spacing: 10) {
                        ForEach(0..<3) { row in
                            HStack(spacing: 10) {
                                ForEach(0..<3) { col in
                                    Rectangle()
                                        .foregroundStyle(.lightLavender)
                                        .aspectRatio(1, contentMode: .fit)
                                        .shadow(radius: 2)
                                        .overlay {
                                            Text(board[row][col]) // X or O goes here
                                                .font(.system(size: 50))
                                                .bold()
                                                .foregroundColor(board[row][col] == "X" ? .blue : .red)
                                        }
                                        .onTapGesture {
                                            if board[row][col] == "" && winner == nil {
                                                withAnimation {
                                                    board[row][col] = isXTurn ? "X" : "O"
                                                }
                                            }
                                            
                                            if checkWinner() {
                                                winner = isXTurn ? "X" : "O"
                                            } else if isBoardFull() {
                                                winner = "Nobody"
                                            } else {
                                                isXTurn.toggle()
                                            }
                                        }
                                        
                                }
                            }
                        }
                    }
                    
                }
                .padding(10)

            }
        }
    }
    
    func checkWinner() -> Bool {
        return false
    }
    
    func isBoardFull() -> Bool {
          for row in board {
              if row.contains("") { return false }
          }
          return true
      }
    
    func resetGame() {
        board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        isXTurn = true
        winner = nil
    }
}


#Preview {
    ContentView()
}
