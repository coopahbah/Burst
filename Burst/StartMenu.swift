import Foundation
import UIKit

class StartMenu : UIViewController {
    let ud = UserDefaults.standard
    
    @IBOutlet weak var RecentScore: UILabel!
    @IBOutlet weak var HighScore: UILabel!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setRecentScore()
        setHighScore()
    }
    
    func setRecentScore() {
        var recentScore = ud.string(forKey: "Score")
        if (recentScore == nil) {
            recentScore = "0"
            ud.set(recentScore, forKey: "Score")
        }
        RecentScore.text = "Recent Score: " + recentScore!
    }
    
    func setHighScore() {
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
