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
    var currentPlayer: Player = .first
    
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
            
            self.switchCurrentPlayer()
            
            if self.currentState.isMoveCompleted {
                self.nextPlayerTurn()
            }
        }
    }
    
    private func switchCurrentPlayer() {
        if currentPlayer == .first {
            currentPlayer = .second
        } else {
            currentPlayer = .first
        }
    }
    
    private func firstPlayerTurn() {
        //        let firstPlayer: Player = .first
        currentState = PlayerGameState(player: currentPlayer, gameViewContoller: self,
                                       gameBoard: gameBoard,
                                       gameBoardView: gameboardView, markViewPrototype: currentPlayer.markViewPrototype)
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
        
        switch currentPlayer {
        case .first:
            currentState = PlayerGameState(player: currentPlayer,
                                           gameViewContoller: self,
                                           gameBoard: gameBoard, gameBoardView: gameboardView,
                                           markViewPrototype: currentPlayer.markViewPrototype)
//            currentPlayer = .second
        case .second:
            currentState = ComputerPlayerGameState(player: currentPlayer,
                                                   gameViewContoller: self,
                                                   gameBoard: gameBoard, gameBoardView: gameboardView,
                                                   markViewPrototype: currentPlayer.markViewPrototype)
//            currentPlayer = .first
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

