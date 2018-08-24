import SpriteKit
import GameplayKit
import Foundation
import UIKit

private var bubblesPopped: Int = 0

class GameScene: SKScene {
    let ud = UserDefaults.standard
    
    private let screenSize: CGRect = UIScreen.main.bounds
    private var maxX: Double = 0.0
    private var maxY: Double = 0.0
    private let maxScale: CGFloat = 75.0
    
    private var bubbleTimer: Timer! = Timer()
    private var endTimer: Timer! = Timer()
    private var endPhaseTimer: Timer! = Timer()
    private var phaseLengthTimer: Timer! = Timer()
    
    private var bubbleAppear: TimeInterval = 1.0
    private var growDuration: TimeInterval = 6.0
    
    override func didMove(to view: SKView) {
        maxX = Double(screenSize.width - 10.0)
        maxY = Double(screenSize.height - 10.0)
        
        bubblesPopped = 0
        startPhase()
    }
    
    @objc func startPhase() {
        bubbleTimer = Timer.scheduledTimer(timeInterval: bubbleAppear, target: self, selector: #selector(addBubble), userInfo: nil, repeats: true)
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
        phaseLengthTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(startPhase), userInfo: nil, repeats: false)
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
    
    @objc func addBubble() {
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
        if (endTimer != nil) {
            endTimer.invalidate()
            endTimer = nil
        }
        if (bubbleTimer != nil) {
            bubbleTimer.invalidate()
            bubbleTimer = nil
        }
        if (endTimer != nil) {
            endTimer.invalidate()
            endTimer = nil
        }
        for node in self.children {
            node.removeFromParent()
        }
        gameVC?.dismiss(animated: true)
        if (bubblesPopped > ud.integer(forKey: "High Score")) {
            ud.set(bubblesPopped, forKey: "High Score")
        }
        ud.set(bubblesPopped, forKey: "Score")
    }
}

class Bubble : SKShapeNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromParent()
        bubblesPopped += 1
    }
}


