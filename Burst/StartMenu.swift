import Foundation
import UIKit

class StartMenu : UIViewController {
    @IBOutlet weak var HighScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ud = UserDefaults.standard
        var highScore = ud.string(forKey: "High Score")
        if (highScore == nil) {
            highScore = "0"
            ud.set(highScore, forKey: "High Score")
        }
        HighScore.text = "High Score: " + highScore!
    }
    
    @IBAction func Play(_ sender: Any) {
        view.endEditing(true)
        performSegue(withIdentifier: "Play", sender: self)
    }
}
