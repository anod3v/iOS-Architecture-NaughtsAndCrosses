//
//  ComputerPlaceMoveGameState.swift
//  XO-game
//
//  Created by Andrey on 27/12/2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class ComputerPlaceMoveGameState: GameState {
    
    var isMoveCompleted: Bool = false
    
    public let player: Player
    public let position: GameboardPosition
    weak var gameViewController: GameViewController?
    weak var gameBoard: Gameboard?
    weak var gameBoardView: GameboardView?
    
    let markViewPrototype: MarkView
    
    init(player: Player, position: GameboardPosition, gameViewContoller: GameViewController,
         gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.position = position
        self.gameBoard = gameBoard
        self.gameViewController = gameViewContoller
        self.gameBoardView = gameBoardView
        
        self.markViewPrototype = markViewPrototype
    }
    
    func addSign(at position: GameboardPosition) {
        guard let gameBoardView = gameBoardView, gameBoardView.canPlaceMarkView(at: position) else { return }
        
        let markView: MarkView
        
        Logger.shared.log(action: .playerSetSign(player: player, position: position))
        gameBoard?.setPlayer(player, at: position)
        
        
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
        isMoveCompleted = true
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
        
        gameBoardView?.onSelectPosition!(position)
    }
    
    
}
