//
//  WelcomeViewController.swift
//  XO-game
//
//  Created by Andrey on 29/12/2020.
//  Copyright © 2020 plasmon. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let pvpClassicButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Друг против друга", for: .normal)
        button.addTarget(self, action: #selector(pvpClassicButtonAction), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let pvcButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Против компьютера", for: .normal)
        button.addTarget(self, action: #selector(pvcButtonAction), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let pvpBlindButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Друг против друга вслепую", for: .normal)
        button.addTarget(self, action: #selector(pvpBlindButtonAction), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        self.view.addSubview(pvpClassicButton)
        self.view.addSubview(pvcButton)
        self.view.addSubview(pvpBlindButton)
    }
    
    @objc func pvpClassicButtonAction(sender: UIButton!) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = storyBoard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        gameViewController.modalPresentationStyle = .fullScreen
        gameViewController.gameMode = .playerVsPlayer
        self.show(gameViewController, sender: nil)
    }
    
    @objc func pvcButtonAction(sender: UIButton!) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = storyBoard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        gameViewController.modalPresentationStyle = .fullScreen
        gameViewController.gameMode = .playerVsComputer
        self.show(gameViewController, sender: nil)
    }
    
    @objc func pvpBlindButtonAction(sender: UIButton!) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = storyBoard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        gameViewController.modalPresentationStyle = .fullScreen
        gameViewController.gameMode = .playerVsPlayerBlind
        self.show(gameViewController, sender: nil)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            pvcButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 3),
            pvcButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pvcButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pvcButton.heightAnchor.constraint(equalToConstant: 40),
            
            pvpClassicButton.topAnchor.constraint(equalTo: pvcButton.bottomAnchor, constant: 26),
            pvpClassicButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pvpClassicButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pvpClassicButton.heightAnchor.constraint(equalToConstant: 40),
            
            pvpBlindButton.topAnchor.constraint(equalTo: pvpClassicButton.bottomAnchor, constant: 26),
            pvpBlindButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pvpBlindButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pvpBlindButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
}

