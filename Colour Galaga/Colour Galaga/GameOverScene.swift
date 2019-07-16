//
//  GameOverScene.swift
//  Colour Galaga
//
//  Created by Mitali Ahir on 2019-07-16.
//  Copyright © 2019 Mitali Ahir. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene
{
    let startButtonNode = SKSpriteNode(imageNamed: "start")
    let gameOverNode = SKSpriteNode(imageNamed: "textGameOver")
    
    override func didMove(to view: SKView)
    {
        startButtonNode.position = CGPoint(x: self.size.width/2, y: self.size.height/4)
        addChild(startButtonNode)
        
        gameOverNode.setScale(0.5)
        gameOverNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        addChild(gameOverNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        if let location = touch?.location(in: self)
        {
            
            if atPoint(location) == startButtonNode
            {
                let gameScene = GameScene(size: self.size)
                let transition = SKTransition.crossFade(withDuration: 1.5)
                self.view?.presentScene(gameScene, transition: transition)
                
            }
        }
    }
}
