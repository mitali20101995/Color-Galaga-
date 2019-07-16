//
//  GameScene.swift
//  Colour Galaga
//
//  Created by Mitali Ahir on 2019-07-09.
//  Copyright © 2019 Mitali Ahir. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    let playerNode = SKSpriteNode(imageNamed: "playerShip")
    let bgNode = SKSpriteNode(imageNamed: "bg_small")
    
    
    override func didMove(to view: SKView)
    {
        
        addPlayer()
        addBackground()
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: {(timer) in self.addEnemy()})
       
        
    }
    
    func addPlayer()
    {
        playerNode.anchorPoint = .zero
        playerNode.setScale(1.0)
        playerNode.zPosition = 1
        addChild(playerNode)
    }
    
    func addBackground()
    {
        bgNode.zPosition = 0
        bgNode.anchorPoint = .zero
        addChild(bgNode)
    }
    
    func addEnemy()
    {
        let redEnemyNode = SKSpriteNode(imageNamed: "enemyShip_red")
        redEnemyNode.zPosition = 1
        redEnemyNode.position = CGPoint(x: self.size.width/2, y: self.size.height)
        
        let moveAction = SKAction.moveTo(y:0, duration: 5)
        let deleteAction = SKAction.removeFromParent()
        let scaleAction = SKAction.scale(to: 0.7, duration: 1)
        redEnemyNode.run(SKAction.sequence([moveAction, scaleAction, deleteAction]))
        
        addChild(redEnemyNode)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        if let location = touch?.location(in: self)
        {
            playerNode.position.x = location.x
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //addEnemy()
    }
    
    override func sceneDidLoad() {
  
    }
   
    func touchDown(atPoint pos : CGPoint) {
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint)
    {
        
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
            }
    
   
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
      
}
