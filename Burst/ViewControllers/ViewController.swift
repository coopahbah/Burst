import Foundation
import UIKit

class ViewController: UIViewController {
    let ud = UserDefaults.standard
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
