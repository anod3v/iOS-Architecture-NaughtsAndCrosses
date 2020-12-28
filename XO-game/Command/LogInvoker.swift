//
//  LogInvoker.swift
//  XO-game
//
//  Created by Veaceslav Chirita on 24.12.2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import Foundation

class LogInvoker {
    public static let shared = LogInvoker()
    
    private let receiver = LogReceiver()
    private let bufferSize = 10
    private var commands: [LogCommand] = []
    private var commandsSorted: [LogCommand] = []
    var player: Player = .first
    
    private init() {}
    
    func addLogCommand(command: LogCommand) {
        commands.append(command)
        execute()
    }
    
    private func execute() {
        guard commands.count >= bufferSize else {
            return
        }
        
        for index in commands.indices {
            //            let move = commands.first(where: {$0.moveData.player == player })
            if let idx = commands.firstIndex(where: { $0.moveData.player == player }) {
                commandsSorted.append(commands[idx])
                commands.remove(at: idx)
                player = player.next
            }
            
//            commands.forEach { receiver.sendMessage(message: $0.moveData) }
//            commands = []
        }
        receiver.commandsSorted?(commandsSorted)
}
}
