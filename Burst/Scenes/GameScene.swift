import Foundation
import SpriteKit
import AVFoundation
import AVKit

var bubblesPopped: Int = 0

class Game: SKScene {
    let ud = UserDefaults.standard
    var maxX: Double = Double(UIScreen.main.bounds.width)
    var maxY: Double = Double(UIScreen.main.bounds.height)
    
    var bubbleTimer: Timer! = Timer()
    var endTimer: Timer! = Timer()
    var endPhaseTimer: Timer! = Timer()
    var downtimeTimer: Timer! = Timer()
    
    class Bubble : SKShapeNode, AVAudioPlayerDelegate {
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            let sound = SKAction.playSoundFileNamed("Pop.wav", waitForCompletion: false)
            run(sound)
            Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(removeBubble), userInfo: nil, repeats: false)
        }
        
        @objc func removeBubble() {
            self.removeFromParent()
            bubblesPopped += 1
        }
    }
}
