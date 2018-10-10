import UIKit
import SpriteKit
import GameplayKit

class GameViewController: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = chooseGame()
            gameVC = self
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
        }
    }
    
    func chooseGame() -> SKScene {
        let chosenGame = UserDefaults.standard.string(forKey: "Game")
        switch chosenGame {
        case "Defense":
            return GameScene(fileNamed: "DefendGameScene")!
        case "Hero":
            return GameScene(fileNamed: "HeroGameScene")!
        default:
            return GameScene(fileNamed: "ClassicGameScene")!
        }
    }
}
