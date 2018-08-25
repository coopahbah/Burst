import UIKit
import SpriteKit

private var bubblesPopped: Int = 0
let playerCategory:UInt32 = 0x1 << 0;
let bubbleCategory:UInt32 = 0x1 << 1;

class DefendGameScene: SKScene, SKPhysicsContactDelegate {
    let ud = UserDefaults.standard
    
    private var maxX: Double = Double(UIScreen.main.bounds.width)
    private var maxY: Double = Double(UIScreen.main.bounds.height)
    
    private var bubbleTimer: Timer! = Timer()
    private var endPhaseTimer: Timer! = Timer()
    private var downtimeTimer: Timer! = Timer()
    
    private var bubbleAppear: TimeInterval = 1.0
    private var bubbleForce: Float = 8.0
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        let zeroGravityVector = CGVector(dx: 0.0, dy: 0.0)
        self.physicsWorld.gravity = zeroGravityVector
        
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
        downtimeTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(startPhase), userInfo: nil, repeats: false)
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
        player.physicsBody!.affectedByGravity = true
        
        self.addChild(player)
        setUpGravity(player: player)
    }
    
    @objc func addBubble() {
        let bubble = DefendBubble(circleOfRadius: 40.0)
        bubble.position = randomEdgePosition(width: maxX, height: maxY)
        bubble.isUserInteractionEnabled = true
        bubble.fillColor = randomColor()
        bubble.strokeColor = UIColor.clear
        bubble.alpha = 1.0
    
        setUpPhysics(bubble: bubble)
        self.addChild(bubble)
    }
    
    func setUpPhysics(bubble: DefendBubble) {
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: 25.0)
        bubble.physicsBody!.isDynamic = true
        bubble.physicsBody!.categoryBitMask = bubbleCategory
        bubble.physicsBody!.contactTestBitMask = playerCategory
        bubble.physicsBody!.collisionBitMask = bubbleCategory
        bubble.physicsBody!.affectedByGravity = true
        bubble.physicsBody!.friction = 0.0
    }
    
    override func update(_ currentTime: TimeInterval) {
        /*
        for bubble in self.children {
            if (bubble as? DefendBubble != nil) {
                let bubblePosition = bubble.position
                let direction = CGVector(dx: -1.0 * bubblePosition.x, dy: -1.0 * bubblePosition.y)
                let newX = direction.dy * 0.035
                let newY = -0.020 * direction.dx
                let newForce = CGVector(dx: newX, dy: newY)
                bubble.physicsBody!.applyForce(newForce)
            }
        }
 */
    }
    
    func setUpGravity(player: SKShapeNode) {
        let gravityField = SKFieldNode.radialGravityField()
        gravityField.isEnabled = true
        gravityField.position = player.position
        gravityField.strength = Float(bubbleForce)
        self.addChild(gravityField)
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
