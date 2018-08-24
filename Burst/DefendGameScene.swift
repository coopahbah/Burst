import UIKit
import SpriteKit

private var bubblesPopped: Int = 0
let playerCategory:UInt32 = 0x1 << 0;
let bubbleCategory:UInt32 = 0x1 << 1;

class DefendGameScene: SKScene, SKPhysicsContactDelegate {
    var gameVC: GameViewController?
    let ud = UserDefaults.standard
    
    private let screenSize: CGRect = UIScreen.main.bounds
    private var maxX: Double = 0.0
    private var maxY: Double = 0.0
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        maxX = Double(screenSize.width)
        maxY = Double(screenSize.height)
        
        bubblesPopped = 0
        addPlayer()
        addBubble()
    }
    
    func addPlayer() {
        let playerSize = CGSize(width: 75, height: 75)
        let player = SKShapeNode(rectOf: playerSize, cornerRadius: 15.0)
        player.position = CGPoint(x: 0.0, y: 0.0)
        player.fillColor = UIColor.darkGray
        player.strokeColor = UIColor.clear
        player.alpha = 1.0
        
        player.physicsBody = SKPhysicsBody(rectangleOf: playerSize)
        player.physicsBody!.isDynamic = true
        player.physicsBody!.categoryBitMask = playerCategory
        player.physicsBody!.contactTestBitMask = bubbleCategory
        player.physicsBody!.collisionBitMask = playerCategory
        player.physicsBody!.affectedByGravity = false
        
        self.addChild(player)
    }
    
    func addBubble() {
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
        let moveAction = SKAction.move(to: CGPoint(x: 0.0, y: 0.0), duration: 6.0)
        bubble.run(moveAction)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("ow")
    }
}

class DefendBubble : SKShapeNode {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromParent()
        bubblesPopped += 1
    }
}
