import Foundation
import UIKit

class GameSelectMenu: ViewController {
    @IBAction func PlayClassic(_ sender: Any) {
        ud.set("Classic", forKey: "Game")
        performSegue(withIdentifier: "PlayGame", sender: self)
    }

    @IBAction func PlayDefense(_ sender: Any) {
        ud.set("Defense", forKey: "Game")
        performSegue(withIdentifier: "PlayGame", sender: self)
    }
    
    @IBAction func Back(_ sender: Any) {
        performSegue(withIdentifier: "BackToMenu", sender: self)
    }
}
