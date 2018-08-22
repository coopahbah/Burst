import Foundation
import UIKit

class StartMenu : UIViewController {
    @IBAction func Play(_ sender: Any) {
        view.endEditing(true)
        performSegue(withIdentifier: "Play", sender: self)
    }
}
