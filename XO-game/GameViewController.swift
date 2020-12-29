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
    
    var gameMode = GameMode.playerVsPlayerBlind
    var currentPlayer: Player = .first
    var receiver = LogReceiver()
    var commands = [LogCommand]()


private var currentState: GameState! {
    didSet {
        currentState.begin()
    }
}

enum GameMode {
    case playerVsPlayer
    case playerVsComputer
    case playerVsPlayerBlind
    case selfPlacingMode
}

override func viewDidLoad() {
    super.viewDidLoad()
    
    //первый делает ход
    firstPlayerTurn()
    
    LogReceiver.shared.commandsSorted = { [weak self] result in
        guard let self = self else { return }
        self.commands = result
        self.gameMode = .selfPlacingMode
        self.firstPlayerTurn()
    }
    
    gameboardView.onSelectPosition = { [weak self] position in
        guard let self = self else { return }
        
        self.currentState.addSign(at: position)
        self.counter += 1
        
        if self.currentState.isMoveCompleted {
            self.nextPlayerTurn()
        }
    }
}
    
//    private func placeAllMoves(commands: [LogCommand]) {
//
//    }

private func firstPlayerTurn() {
    switch gameMode {
    case .selfPlacingMode:
        if let move = commands.first?.moveData {
        let currentPosition = move.position
        commands.removeFirst()
            currentState = ComputerPlaceMoveGameState(player: move.player, position: currentPosition, gameViewContoller: self,
                                           gameBoard: gameBoard,
                                           gameBoardView: gameboardView, markViewPrototype: move.player.markViewPrototype)
        }
        
    default:
        currentPlayer = .first
        currentState = PlayerGameState(player: currentPlayer, gameViewContoller: self,
                                       gameBoard: gameBoard,
                                       gameBoardView: gameboardView, markViewPrototype: currentPlayer.markViewPrototype)
    }
}

private func checkIfWin() -> Bool {
    if let winner = referee.determineWinner() {
        currentState = GameEndState(winnerPlayer: winner, gameViewController: self)
//        Logger.shared.log(action: .gameFinished(winned: winner))
        return true
    }
    return false
}

private func checkIfEnd() -> Bool {
    if counter >= GameboardSize.columns  * GameboardSize.rows {
//        Logger.shared.log(action: .gameFinished(winned: nil))
        currentState = GameEndState(winnerPlayer: nil, gameViewController: self)
        return true
    }
    return false
}

private func nextPlayerTurn() {
    
    switch gameMode {
    case .playerVsComputer:
        guard checkIfWin() == false else { return }
        guard checkIfEnd() == false else { return }
        currentPlayer = currentPlayer.next
        switch currentPlayer {
        case .first:
            currentState = PlayerGameState(player: currentPlayer,
                                           gameViewContoller: self,
                                           gameBoard: gameBoard, gameBoardView: gameboardView,
                                           markViewPrototype: currentPlayer.markViewPrototype)
        case .second:
            currentState = ComputerPlayerGameState(player: currentPlayer,
                                                   gameViewContoller: self,
                                                   gameBoard: gameBoard, gameBoardView: gameboardView,
                                                   markViewPrototype: currentPlayer.markViewPrototype)
        }
    case .playerVsPlayer:
        guard checkIfWin() == false else { return }
        guard checkIfEnd() == false else { return }
        if let playerState = currentState as? PlayerGameState {
            let nextPlayer = playerState.player.next
            currentState = PlayerGameState(player: nextPlayer,
                                           gameViewContoller: self,
                                           gameBoard: gameBoard, gameBoardView: gameboardView,
                                           markViewPrototype: nextPlayer.markViewPrototype)
        }
    case .playerVsPlayerBlind:
        switch counter {
        case 5:
            gameboardView.clear()
            currentPlayer = currentPlayer.next
        case 10:
            guard checkIfWin() == false else { return }
            guard checkIfEnd() == false else { return }
        default:
            return
        }
        if let playerState = currentState as? PlayerGameState {
            let nextPlayer = playerState.player.next
            currentState = PlayerGameState(player: nextPlayer,
                                           gameViewContoller: self,
                                           gameBoard: gameBoard, gameBoardView: gameboardView,
                                           markViewPrototype: nextPlayer.markViewPrototype)
        }
        
    case .selfPlacingMode:
        if let move = commands.first?.moveData {
        commands.removeFirst()
        let currentPosition = move.position
        currentState = ComputerPlaceMoveGameState(player: move.player, position: currentPosition, gameViewContoller: self,
                                           gameBoard: gameBoard,
                                           gameBoardView: gameboardView, markViewPrototype: move.player.markViewPrototype)
        }
    }
}

@IBAction func restartButtonTapped(_ sender: UIButton) {
//    Logger.shared.log(action: .restartGame)
    
    gameboardView.clear()
    gameBoard.clear()
    counter = 0
    
    firstPlayerTurn()
}

}

