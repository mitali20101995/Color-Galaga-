//
//  GameScene.swift
//  Colour Galaga
//
//  Created by Mitali Ahir on 2019-07-09.
//  Copyright © 2019 Mitali Ahir. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate
{
    let playerNode = SKSpriteNode(imageNamed: "playerShip")
    let bgNode = SKSpriteNode(imageNamed: "bg_small")
    let playSoundNode = SKSpriteNode(imageNamed: "play")
    let stopSoundNode = SKSpriteNode(imageNamed: "pause")
    var enemyTimer = Timer()
    var scores = 0
    var lives = 0
    let scorelable = SKLabelNode(text: "0")
    let liveLable = SKLabelNode(text: "3")
    var gameTime = 0
    
    var audioPlayer = AVAudioPlayer()
    var gameSoundURL: URL?
    var musicplayer = AVAudioPlayer()
    var musicURL: URL?
    
    override func didMove(to view: SKView)
    {
        gameSoundURL = Bundle.main.url(forResource: "sound1", withExtension: "mp3")
        musicURL = Bundle.main.url(forResource: "Updraft", withExtension: "mp3")
        
        physicsWorld.contactDelegate = self
        
        addPlayer()
        addBackground()
        enemyTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: {(timer) in self.addEnemy()})
        addScore()
        addLives()
        initSound()
        initMusic()
        addSoundNode()
    }
    
    func addSoundNode()
    {
        playSoundNode.anchorPoint = CGPoint.zero
        //playSoundNode.setScale(0.5)
        playSoundNode.position = CGPoint(x: 10, y: self.size.height - playSoundNode.size.height)
        playSoundNode.zPosition = 4
        addChild(playSoundNode)
        
        stopSoundNode.anchorPoint = CGPoint.zero
       // stopSoundNode.setScale(0.5)
        stopSoundNode.position = CGPoint(x: 10, y: self.size.height - stopSoundNode.size.height)
        stopSoundNode.zPosition = 5
        addChild(stopSoundNode)
    }
    
    
    func initMusic()
    {
        guard let url = musicURL else {return}
        
        do{
            musicplayer = try AVAudioPlayer(contentsOf: url)
        }
        catch{
            print("error")
        }
        musicplayer.numberOfLoops = -1
        musicplayer.prepareToPlay()
        musicplayer.play()
    }
    
    func initSound()
    {
        guard let url = gameSoundURL else {return}
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        }
        catch{
            print("error")
        }
        audioPlayer.numberOfLoops = 1
        audioPlayer.prepareToPlay()
    }
    
    func addPlayer()
    {
        playerNode.position = CGPoint(x: playerNode.size.width/2, y: playerNode.size.height/2)
        playerNode.setScale(1.0)
        playerNode.zPosition = 1
        playerNode.physicsBody = SKPhysicsBody(rectangleOf: playerNode.size)
        playerNode.physicsBody?.affectedByGravity = false
        playerNode.physicsBody?.isDynamic = false
        playerNode.name = "player"
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
        gameTime += 1
        let randomx = arc4random_uniform(UInt32(self.size.width))
        
        let redEnemyNode = SKSpriteNode(imageNamed: "enemyShip_red")
        redEnemyNode.zPosition = 1
        redEnemyNode.position.y = self.size.height
        redEnemyNode.position.x = CGFloat(randomx)
        
        let moveAction = SKAction.moveTo(y:0, duration: 5)
        let deleteAction = SKAction.removeFromParent()
        let scaleAction = SKAction.scale(to: 0.7, duration: 1)
        redEnemyNode.run(SKAction.sequence([moveAction, scaleAction, deleteAction]))
        
        redEnemyNode.physicsBody = SKPhysicsBody(rectangleOf: redEnemyNode.size)
        redEnemyNode.physicsBody?.affectedByGravity = false
        redEnemyNode.name = "RedEnemy"
        //redEnemyNode.physicsBody?.isDynamic = false
        redEnemyNode.physicsBody?.contactTestBitMask = (redEnemyNode.physicsBody?.collisionBitMask)!
        addChild(redEnemyNode)
        
        if gameTime > 10
        {
            enemyTimer.invalidate()
            presentGameSceneOver()
        }
    }
    
    func addScore()
    {
        scorelable.color = .white
        scorelable.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        addChild(scorelable)
    }
    
    func addLives()
    {
        liveLable.color = .white
        liveLable.position = CGPoint(x: 60, y: 5)
        addChild(liveLable)
    }
    
    func addBlink(node:SKSpriteNode)
    {
        let fadeAction = SKAction.sequence([SKAction.fadeAlpha(to: 0.1, duration: 0.1),SKAction.fadeAlpha(to: 1.0, duration: 0.1)])
        let repeatAction = SKAction.repeat(fadeAction, count: 3)
        node.run(repeatAction)
    }
    
    func shoot() {
        
        let bullet = SKSpriteNode(color: SKColor.blue, size: CGSize(width: 4,height: 4))
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: 2)
        bullet.physicsBody?.affectedByGravity = false
        bullet.position = CGPoint(x: playerNode.position.x, y: playerNode.position.y)
        bullet.name = "blueBullet"
        addChild(bullet)
        
        let rotationOffset = CGFloat.pi/2
        let vector = rotate(vector: CGVector(dx: 0.25, dy: 0), angle:playerNode.zRotation+rotationOffset)
        bullet.physicsBody?.applyImpulse(vector)
    }
    
    func rotate(vector:CGVector, angle:CGFloat) -> CGVector {
        let rotatedX = vector.dx * cos(angle) - vector.dy * sin(angle)
        let rotatedY = vector.dx * sin(angle) + vector.dy * cos(angle)
        return CGVector(dx: rotatedX, dy: rotatedY)
    }
    
    func presentGameSceneOver()
    {
        let gameOverScene = GameOverScene(size: self.size)
        let transition = SKTransition.doorway(withDuration: 1.5)
        self.view?.presentScene(gameOverScene, transition: transition)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        let touch = touches.first
        if let location = touch?.location(in: self)
        {
           
            playerNode.position.x = location.x
           
        }
      
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        print("Contact")
        audioPlayer.play()
        
        
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if nodeB.name == "RedEnemy"
        {
              print("node B is red enemy")
            
           // nodeA.removeFromParent()
            //addBlink(node: playerNode)
           // lives = lives - 1
        }
        if nodeA.name == "blueBullet"
        {
            print("node A is bullet")
            
        }
        
        scores += 1
        scorelable.text = "Score: \(scores)"
        liveLable.text = "Lives: \(lives)"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
         let touch = touches.first
        if let location = touch?.location(in: self)
        {
            shoot()
            if atPoint(location) == stopSoundNode
            {
                stopSoundNode.zPosition = 4
                playSoundNode.zPosition = 5
                musicplayer.pause()
                return
            }
            else if atPoint(location) == playSoundNode
            {
                stopSoundNode.zPosition = 5
                playSoundNode.zPosition = 4
                musicplayer.play()
                return
            }
            
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
   override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
      
}
