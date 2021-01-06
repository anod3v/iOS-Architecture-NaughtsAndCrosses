//
//  LogCommand.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 24.12.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class LogCommand {
    let action: LogAction
    
    init(action: LogAction) {
        self.action = action
    }
    
    var moveData: MoveData {
        switch action {
        case .playerSetSign(let player, let position):
            return MoveData(player: player, position: position)
        }
    }
}

struct MoveData {
    let player: Player
    let position: GameboardPosition
}

