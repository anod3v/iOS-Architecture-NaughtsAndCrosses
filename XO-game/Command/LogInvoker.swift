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
    private let bufferSize = 6
    private var commands: [LogCommand] = []
    
    private init() {}
    
    func addLogCommand(command: LogCommand) {
        commands.append(command)
        execute()
    }
    
    private func execute() {
        guard commands.count >= bufferSize else {
            return
        }
        
        commands.forEach { receiver.sendMessage(message: $0.logMessage) }
        commands = []
    }
}
