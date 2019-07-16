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
    var scorelable = SKLabelNode()
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
        scores += 1
        scorelable.text = "Score: \(scores)"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
         let touch = touches.first
        if let location = touch?.location(in: self)
        {
           
            if atPoint(location) == stopSoundNode
            {
                stopSoundNode.zPosition = 4
                playSoundNode.zPosition = 5
                musicplayer.pause()
            }
            else if atPoint(location) == playSoundNode
            {
                stopSoundNode.zPosition = 5
                playSoundNode.zPosition = 4
                musicplayer.play()
            }
        }
    }
    
   override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
      
}
