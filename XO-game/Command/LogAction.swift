//
//  LogAction.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 24.12.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

enum LogAction {
    case playerSetSign(player: Player, position: GameboardPosition)
    case gameFinished(winned: Player?)
    case restartGame
}
