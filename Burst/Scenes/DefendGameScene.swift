import UIKit
import SpriteKit

let playerCategory:UInt32 = 0x1 << 0;
let bubbleCategory:UInt32 = 0x1 << 1;

class DefendGameScene: Game, SKPhysicsContactDelegate {
    private var bubbleAppear: TimeInterval = 1.0
    private var bubbleForce: Float = 8.0
    
    private let bubbleRadius: Double = 40.0
    private var hardMode: Bool = false
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        hardMode = ud.bool(forKey: "Hard Mode")

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
        player.name = "Player"
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
        let bubble = Bubble(circleOfRadius: CGFloat(bubbleRadius))
        bubble.position = randomEdgePosition(width: maxX - 40.0, height: maxY - 40.0)
        bubble.isUserInteractionEnabled = true
        bubble.fillColor = randomColor()
        bubble.strokeColor = UIColor.clear
        bubble.alpha = 1.0
    
        setUpPhysics(bubble: bubble)
        self.addChild(bubble)
    }
    
    func setUpPhysics(bubble: Bubble) {
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: 25.0)
        bubble.physicsBody!.isDynamic = true
        bubble.physicsBody!.categoryBitMask = bubbleCategory
        bubble.physicsBody!.contactTestBitMask = playerCategory
        bubble.physicsBody!.collisionBitMask = bubbleCategory
        bubble.physicsBody!.affectedByGravity = true
        bubble.physicsBody!.friction = 0.0
    }
    
    override func update(_ currentTime: TimeInterval) {
        for bubble in self.children {
            if (bubble.position.x.magnitude >= CGFloat(maxX - bubbleRadius) && bubble.physicsBody!.velocity.dx != 0.0) {
                bubble.physicsBody!.velocity.dx *= -1.0
            }
            
            if (bubble.position.y.magnitude >= CGFloat(maxY - bubbleRadius) && bubble.physicsBody!.velocity.dy != 0.0) {
                bubble.physicsBody!.velocity.dy *= -1.0
            }
            
            if (hardMode && bubble as? Bubble != nil) {
                let bubblePosition = bubble.position
                let direction = CGVector(dx: -1.0 * bubblePosition.x, dy: -1.0 * bubblePosition.y)
                
                let newX = direction.dy * 0.1
                let newY = direction.dx * -0.1
                let newForce = CGVector(dx: newX, dy: newY)
                
                bubble.physicsBody!.applyForce(newForce)
            }
        }
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


