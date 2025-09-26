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

                }
                
                Button("Play Again") {
                    resetGame()
                }
                .foregroundStyle(.softLavender)
                
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
                                        .onDrop(of: ["public.text"], isTargeted: nil) { providers in
                                            guard board[row][col] == "" else { return false }
                                            
                                            if let item = providers.first {
                                                _ = item.loadObject(ofClass: String.self) { object, error in
                                                    if let symbol = object {
                                                        DispatchQueue.main.async {
                                                            board[row][col] = symbol
                                                        }
                                                    }
                                                }
                                                return true
                                            }
                                            return false
                                        }
                                    /*
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
                                        */
                                }
                            }
                        }
                    }
                    
                }
                .padding(10)

                // Dragging symbols
                HStack(spacing: 50) {
                    ForEach(["X", "O"], id: \.self) { symbol in
                        Text(symbol)
                            .font(.system(size: 50))
                            .bold()
                            .foregroundColor(symbol == "X" ? .blue : .red)
                            .padding()
                            .background(Color.lightLavender)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                            .onDrag {
                                // draggedSymbol = symbol
                                NSItemProvider(object: NSString(string: symbol))
                            }
                    }
                }

            }
        }
    }
    
    func checkWinner(symbol: String) -> Bool {
        
        let lines = [
            //Horizontal
            [(0,0), (0,1), (0,2)],
            [(1,0), (1,1), (1,2)],
            [(2,0), (2,1), (2,2)],
            //Vertical
            [(0,0), (1,0), (2,0)],
            [(0,1), (1,1), (2,1)],
            [(0,2), (1,2), (2,2)],
            //Diagonal
            [(0,0), (1,1), (2,2)],
            [(0,2), (1,1), (2,0)]
        ]
        
        for line in lines {
            let (xR, xC) = line[0]
            let (yR, yC) = line[1]
            let (zR, zC) = line[2]
            
            if board[xR][xC] == symbol &&
               board[yR][yC] == symbol &&
               board[zR][zC] == symbol {
                return true
            }
        }
        
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
    
    func placeSymbol(row: Int, col: Int) {
            guard board[row][col] == "" && winner == nil else { return }
            board[row][col] = isXTurn ? "X" : "O"
            if checkWinner(symbol: board[row][col]) {
                winner = board[row][col]
            } else if isBoardFull() {
                winner = "Nobody"
            } else {
                isXTurn.toggle()
            }
        }
    
}

#Preview {
    ContentView()
}
