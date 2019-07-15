//
//  GameViewController.swift
//  Colour Galaga
//
//  Created by Siddharth Trivedi on 2019-07-09.
//  Copyright © 2019 Mitali Ahir. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      let gameScene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.presentScene(gameScene)
       
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
