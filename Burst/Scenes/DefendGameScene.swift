import UIKit
import SpriteKit

private var bubblesPopped: Int = 0
let playerCategory:UInt32 = 0x1 << 0;
let bubbleCategory:UInt32 = 0x1 << 1;

class DefendGameScene: SKScene, SKPhysicsContactDelegate {
    let ud = UserDefaults.standard
    
    private let screenSize: CGRect = UIScreen.main.bounds
    private var maxX: Double = 0.0
    private var maxY: Double = 0.0
    
    private var bubbleTimer: Timer! = Timer()
    private var endPhaseTimer: Timer! = Timer()
    private var downtimeTimer: Timer! = Timer()
    
    private var bubbleAppear: TimeInterval = 1.0
    private var bubbleSpeed: TimeInterval = 6.0
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        maxX = Double(screenSize.width)
        maxY = Double(screenSize.height)
        
        bubblesPopped = 0
        addPlayer()
        startPhase()
    }
    
    @objc func startPhase() {
        bubbleTimer = Timer.scheduledTimer(timeInterval: bubbleAppear, target: self, selector: #selector(addBubble), userInfo: nil, repeats: true)
        endPhaseTimer = Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(endPhase), userInfo: nil, repeats: false)
    }
    
    @objc func endPhase() {
        if (bubbleTimer != nil) {
            bubbleTimer.invalidate()
        }
        if (endPhaseTimer != nil) {
            endPhaseTimer.invalidate()
        }
        downtimeTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(startPhase), userInfo: nil, repeats: false)
    }
    
    func addPlayer() {
        let playerSize = CGSize(width: 75, height: 75)
        let player = SKShapeNode(rectOf: playerSize, cornerRadius: 15.0)
        player.position = CGPoint(x: 0.0, y: 0.0)
        player.fillColor = UIColor.darkGray
        player.strokeColor = UIColor.clear
        player.alpha = 1.0
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: playerSize.width / 2)
        player.physicsBody!.isDynamic = true
        player.physicsBody!.categoryBitMask = playerCategory
        player.physicsBody!.contactTestBitMask = bubbleCategory
        player.physicsBody!.collisionBitMask = playerCategory
        player.physicsBody!.affectedByGravity = false
        
        self.addChild(player)
    }
    
    @objc func addBubble() {
        let bubble = DefendBubble(circleOfRadius: 25.0)
        bubble.position = randomEdgePosition(width: maxX, height: maxY)
        bubble.isUserInteractionEnabled = true
        bubble.fillColor = randomColor()
        bubble.strokeColor = UIColor.clear
        bubble.alpha = 1.0
        
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: 25.0)
        bubble.physicsBody!.isDynamic = true
        bubble.physicsBody!.categoryBitMask = bubbleCategory
        bubble.physicsBody!.contactTestBitMask = playerCategory
        bubble.physicsBody!.collisionBitMask = bubbleCategory
        bubble.physicsBody!.affectedByGravity = false
        
        self.addChild(bubble)
        moveBubble(bubble: bubble)
    }
    
    func moveBubble(bubble: DefendBubble) {
        let moveAction = SKAction.move(to: CGPoint(x: 0.0, y: 0.0), duration: bubbleSpeed)
        bubble.run(moveAction)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        endGame()
    }
    
    func endGame() {
        for node in self.children {
            node.removeFromParent()
        }
        
        let timers: [Timer?] = [bubbleTimer, endPhaseTimer, downtimeTimer]
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

class DefendBubble : SKShapeNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromParent()
        bubblesPopped += 1
    }
}
