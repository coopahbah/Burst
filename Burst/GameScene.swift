import SpriteKit
import GameplayKit
import Foundation
import UIKit

private var bubblesPopped: Int = 0

/*
 phases different speeds
 sounds
 color themes
 different game modes
 */

class GameScene: SKScene {
    var gameVC: GameViewController?
    
    private let screenSize: CGRect = UIScreen.main.bounds
    private var maxX: Double = 0.0
    private var minX: Double = 0.0
    private var maxY: Double = 0.0
    private var minY: Double = 0.0
    private let maxScale: CGFloat = 75.0
    
    private var bubbleTimer: Timer! = Timer()
    private var endTimer: Timer! = Timer()
    private var endPhaseTimer: Timer! = Timer()
    private var phaseLengthTimer: Timer! = Timer()
    
    private var bubbleAppear: TimeInterval = 1.0
    private var growDuration: TimeInterval = 6.0
    
    override func didMove(to view: SKView) {
        maxX = Double(screenSize.width - 10.0)
        minX = -1 * maxX
        maxY = Double(screenSize.height - 10.0)
        minY = -1 * maxY
        
        startPhase()
    }
    
    @objc func startPhase() {
        bubbleTimer = Timer.scheduledTimer(timeInterval: bubbleAppear, target: self, selector: #selector(createBubble), userInfo: nil, repeats: true)
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
        phaseLengthTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(startPhase), userInfo: nil, repeats: false)
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
    
    @objc func createBubble() {
        let xPosition = Double.random(in: minX...maxX)
        let yPosition = Double.random(in: minY...maxY)
        let position = CGPoint(x: xPosition, y: yPosition)
        let bubble = Bubble.init(radius: 10.0, position: position)
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
    
    func randomColor() -> UIColor! {
        let redContent = CGFloat.random(in: 0.0...1.0)
        let greenContent = CGFloat.random(in: 0.0...1.0)
        let blueContent = CGFloat.random(in: 0.0...1.0)
        return UIColor(red: redContent, green: greenContent, blue: blueContent, alpha: 1.0)
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
        for node in self.children {
            node.removeFromParent()
        }
        gameVC?.dismiss(animated: true)
    }
}

class Bubble : SKShapeNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromParent()
        bubblesPopped += 1
        UserDefaults.standard.set(String(bubblesPopped), forKey: "High Score")
    }
    
    var radius: Double {
        didSet {
            self.path = Bubble.path(radius: self.radius)
        }
    }
    
    init(radius: Double, position: CGPoint) {
        self.radius = radius
        
        super.init()
        
        self.path = Bubble.path(radius: self.radius)
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func path(radius: Double) -> CGMutablePath {
        let path: CGMutablePath = CGMutablePath()
        path.addArc(center: CGPoint.zero, radius: CGFloat(radius), startAngle: 0.0, endAngle: CGFloat(2.0*Double.pi), clockwise: false)
        return path
    }
}
