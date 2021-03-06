//
//  ComputerPlayerGameState.swift
//  XO-game
//
//  Created by Andrey on 27/12/2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class ComputerPlayerGameState: GameState {
    
        var isMoveCompleted: Bool = false
        
        public let player: Player
        weak var gameViewController: GameViewController?
        weak var gameBoard: Gameboard?
        weak var gameBoardView: GameboardView?
        
        let markViewPrototype: MarkView
        
        init(player: Player, gameViewContoller: GameViewController,
             gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
            self.player = player
            self.gameBoard = gameBoard
            self.gameViewController = gameViewContoller
            self.gameBoardView = gameBoardView
            
            self.markViewPrototype = markViewPrototype
        }
        
        func addSign(at position: GameboardPosition) {
            guard let gameBoardView = gameBoardView, gameBoardView.canPlaceMarkView(at: position) else { return }

            let markView: MarkView

    //        switch player {
    //        case .first:
    //            markView = XView()
    //        case .second:
    //            markView = OView()
    //        }

            Logger.shared.log(action: .playerSetSign(player: player, position: position))
            gameBoard?.setPlayer(player, at: position)


            gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
            isMoveCompleted = true
        }
    
    func getRandomPosition() -> GameboardPosition? {
        guard GameboardSize.columns == GameboardSize.rows else { return nil }
        var allPositions = [GameboardPosition]()
        for i in 0 ..< GameboardSize.columns {
            for j in 0 ..< GameboardSize.rows {
                allPositions.append(GameboardPosition(column: i, row: j))
            }
        }
        allPositions.shuffle()
        for position in allPositions {
            guard let gameBoardView = gameBoardView, gameBoardView.canPlaceMarkView(at: position) else { continue }
            return position
        }
        return nil
    }
        
        func begin() {
            
            switch player {
            case .first:
                gameViewController?.firstPlayerTurnLabel.isHidden = false
                gameViewController?.secondPlayerTurnLabel.isHidden = true
            case .second:
                gameViewController?.firstPlayerTurnLabel.isHidden = true
                gameViewController?.secondPlayerTurnLabel.isHidden = false
            }
            
            gameViewController?.winnerLabel.isHidden = true
            
            let position = getRandomPosition()!
            gameBoardView?.onSelectPosition!(position)
        }
        
        
}
