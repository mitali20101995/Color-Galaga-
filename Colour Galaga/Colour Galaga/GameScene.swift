//
//  GameScene.swift
//  Colour Galaga
//
//  Created by Siddharth Trivedi on 2019-07-09.
//  Copyright © 2019 Mitali Ahir. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    let playerNode = SKSpriteNode(imageNamed: "player")
    override func didMove(to view: SKView)
    {
        playerNode.anchorPoint = .zero
        playerNode.setScale(3.0)
        addChild(playerNode)
    }
    
    override func sceneDidLoad() {
  
    }
   
    func touchDown(atPoint pos : CGPoint) {
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
            }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
