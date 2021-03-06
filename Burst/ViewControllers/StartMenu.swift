import Foundation
import UIKit

class StartMenu : ViewController {
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
        performSegue(withIdentifier: "ChooseGame", sender: self)
    }
}
