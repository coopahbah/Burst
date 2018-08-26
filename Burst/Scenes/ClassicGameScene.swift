import SpriteKit
import GameplayKit
import Foundation
import UIKit
import AVKit
import AudioToolbox

class GameScene: Game {
    private let maxScale: CGFloat = 75.0
    private var bubbleAppear: TimeInterval = 1.0
    private var growDuration: TimeInterval = 6.0
    private var hardMode: Bool = false
    private var numberOfBubbles: Int = 1
    
    override func didMove(to view: SKView) {
        bubblesPopped = 0
        hardMode = ud.bool(forKey: "Hard Mode")
        hardMode = true
        startPhase()
    }
    
    @objc func startPhase() {
        numberOfBubbles += 1
        bubbleTimer = Timer.scheduledTimer(timeInterval: bubbleAppear, target: self, selector: #selector(addBubbles), userInfo: nil, repeats: true)
        endTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkForEnd), userInfo: nil, repeats: true)
        endPhaseTimer = Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(endPhase), userInfo: nil, repeats: false)
        setPhase()
    }
    
    @objc func endPhase() {
        if (bubbleTimer != nil) {
            bubbleTimer.invalidate()
        }
        if (endTimer != nil) {
            endTimer.invalidate()
        }
        downtimeTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(startPhase), userInfo: nil, repeats: false)
    }
    
    func setPhase() {
        if (bubbleAppear > 0.1) {
            bubbleAppear -= 0.15
        } else {
            bubbleAppear = bubbleAppear / 2
        }
        if (growDuration > 2.0) {
            growDuration -= 0.5
        } else if (growDuration > 1.0) {
            growDuration -= 0.1
        }
    }
    
    func addBubble() {
        let xPosition = randomDouble(upper: maxX)
        let yPosition = randomDouble(upper: maxY)
        let bubble = Bubble(circleOfRadius: 10.0)
        bubble.position = CGPoint(x: xPosition, y: yPosition)
        bubble.isUserInteractionEnabled = true
        bubble.fillColor = randomColor()
        bubble.strokeColor = UIColor.clear
        bubble.alpha = 1.0
        self.addChild(bubble)
        growBubble(bubble: bubble)
    }
    
    @objc func addBubbles() {
        if (hardMode) {
            for _ in 0..<numberOfBubbles {
                addBubble()
            }
        } else {
            addBubble()
        }
    }
    
    func growBubble(bubble: Bubble) {
        let scaleAction = SKAction.scale(to: maxScale, duration: growDuration)
        bubble.run(scaleAction)
    }
    
    @objc func checkForEnd() {
        for node in self.children {
            let bubble = node as! Bubble
            if (bubble.xScale >= 75.0) {
                endGame()
            }
        }
    }
    
    func endGame() {
        for node in self.children {
            node.removeFromParent()
        }
        
        let timers: [Timer?] = [bubbleTimer, endTimer, endPhaseTimer, downtimeTimer]
        for timer in timers {
            timer?.invalidate()
        }

        gameVC?.dismiss(animated: true)
        if (bubblesPopped > ud.integer(forKey: "High Score")) {
            ud.set(bubblesPopped, forKey: "High Score")
        }
        ud.set(bubblesPopped, forKey: "Score")
    }
}




