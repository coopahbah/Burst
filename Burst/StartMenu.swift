import Foundation
import UIKit

class StartMenu : UIViewController {
    let ud = UserDefaults.standard
    
    @IBOutlet weak var RecentScore: UILabel!
    @IBOutlet weak var HighScore: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setRecentScore()
        setHighScore()
    }
    
    func setRecentScore() {
        let recentScore = ud.integer(forKey: "Score")
        RecentScore.text = "Recent Score: " + String(recentScore)
    }
    
    func setHighScore() {
        let highScore = ud.integer(forKey: "High Score")
        HighScore.text = "High Score: " + String(highScore)
    }
    
    @IBAction func Play(_ sender: Any) {
        view.endEditing(true)
        ud.set("Classic", forKey: "Game")
        performSegue(withIdentifier: "PlayGame", sender: self)
    }
    
    @IBAction func PlayDefense(_ sender: Any) {
        view.endEditing(true)
        ud.set("Defense", forKey: "Game")
        performSegue(withIdentifier: "PlayGame", sender: self)
    }
}
