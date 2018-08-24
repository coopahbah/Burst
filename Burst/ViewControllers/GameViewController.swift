import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
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
            return SKScene(fileNamed: "DefendGameScene")!
        default:
            return SKScene(fileNamed: "ClassicGameScene")!
        }
    }
}
