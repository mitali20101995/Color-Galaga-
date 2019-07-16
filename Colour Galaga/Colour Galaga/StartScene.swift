//
//  startScene.swift
//  Colour Galaga
//
//  Created by Mitali Ahir on 2019-07-16.
//  Copyright © 2019 Mitali Ahir. All rights reserved.
//

import SpriteKit

class StartScene: SKScene
{
    let startButtonNode = SKSpriteNode(imageNamed: "start")
    let bgNode = SKSpriteNode(imageNamed: "darkPurple")
    let galaxyNode = SKSpriteNode(imageNamed: "space_object_galaxy")
    let mooonNode = SKSpriteNode(imageNamed: "space_object_planetsunrise")
    let shipNode = SKSpriteNode(imageNamed: "playerShip")
    var texture = [SKTexture]()
    
    override func didMove(to view: SKView)
    {
        bgNode.zPosition = 0
        bgNode.anchorPoint = .zero
        bgNode.size = CGSize(width: self.size.width, height: self.size.height)
        addChild(bgNode)
        
        galaxyNode.setScale(0.88)
        galaxyNode.position = CGPoint(x: self.size.width/2, y: self.size.height * 3/4)
        addChild(galaxyNode)
        
        mooonNode.setScale(0.5)
        mooonNode.position = CGPoint(x: self.size.width * 3/4, y: self.size.height/2)
        addChild(mooonNode)
        
        shipNode.position = CGPoint(x: self.size.width/2, y: self.size.height/8)
        addChild(shipNode)
        
        texture.append(SKTexture(imageNamed: "playerShip"))
        texture.append(SKTexture(imageNamed: "playerShipLife"))
        let animateAction = SKAction.animate(with: texture, timePerFrame: 0.5)
        shipNode.run(SKAction.repeatForever(animateAction))
       
        
        startButtonNode.position = CGPoint(x: self.size.width/2, y: self.size.height/4)
        addChild(startButtonNode)
    
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
