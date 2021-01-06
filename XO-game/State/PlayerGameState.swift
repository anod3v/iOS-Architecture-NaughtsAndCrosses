//
//  PlayerGameState.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 24.12.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class PlayerGameState: GameState {
    
    var isMoveCompleted: Bool = false
    
    public let player: Player
    weak var gameViewContoller: GameViewController?
    weak var gameBoard: Gameboard?
    weak var gameBoardView: GameboardView?
    
    let markViewPrototype: MarkView
    
    init(player: Player, gameViewContoller: GameViewController,
         gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameBoard = gameBoard
        self.gameViewContoller = gameViewContoller
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
            gameViewContoller?.firstPlayerTurnLabel.isHidden = false
            gameViewContoller?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewContoller?.firstPlayerTurnLabel.isHidden = true
            gameViewContoller?.secondPlayerTurnLabel.isHidden = false
        }
        
        gameViewContoller?.winnerLabel.isHidden = true
    }
    
    
}
