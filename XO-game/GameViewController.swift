//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private var counter: Int = 0
    private let gameBoard = Gameboard()
    private lazy var referee = Referee(gameboard: gameBoard)
    
    var isComputerModeOn = true
    
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //первый делает ход
        firstPlayerTurn()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            
            self.currentState.addSign(at: position)
            self.counter += 1
            
            if self.currentState.isMoveCompleted {
                self.nextPlayerTurn()
            }
        }
    }
    
    private func firstPlayerTurn() {
        let firstPlayer: Player = .first
        currentState = PlayerGameState(player: firstPlayer, gameViewContoller: self,
                                       gameBoard: gameBoard,
                                       gameBoardView: gameboardView, markViewPrototype: firstPlayer.markViewPrototype)
    }
    
    private func nextPlayerTurn() {
        if let winner = referee.determineWinner() {
            currentState = GameEndState(winnerPlayer: winner, gameViewController: self)
            Logger.shared.log(action: .gameFinished(winned: winner))
            return
        }
        
        if counter >= 9 {
            Logger.shared.log(action: .gameFinished(winned: nil))
            currentState = GameEndState(winnerPlayer: nil, gameViewController: self)
        }
        
        if counter % 2 == 0 {
            
            if let playerState = currentState as? PlayerGameState {
                let nextPlayer = playerState.player.next
                currentState = PlayerGameState(player: nextPlayer,
                                               gameViewContoller: self,
                                               gameBoard: gameBoard, gameBoardView: gameboardView,
                                               markViewPrototype: nextPlayer.markViewPrototype)
            }
        } else {
            
            if let playerState = currentState as? PlayerGameState {
            let nextPlayer = playerState.player.next
            
//            if let playerState = currentState as? ComputerPlayerGameState {
//                let nextPlayer = playerState.player.next
            currentState = ComputerPlayerGameState(player: nextPlayer,
                                                       gameViewContoller: self,
                                                       gameBoard: gameBoard, gameBoardView: gameboardView,
                                                       markViewPrototype: nextPlayer.markViewPrototype)
            }
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Logger.shared.log(action: .restartGame)
        
        gameboardView.clear()
        gameBoard.clear()
        counter = 0
        
        firstPlayerTurn()
    }
    
}

