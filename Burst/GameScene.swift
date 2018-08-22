import SpriteKit
import GameplayKit
import Darwin

class GameScene: SKScene {
    private let screenSize: CGRect = UIScreen.main.bounds
    private var maxX: Double = 0.0
    private var minX: Double = 0.0
    private var maxY: Double = 0.0
    private var minY: Double = 0.0
    private var bubbleTimer: Timer! = Timer()
    
    override func didMove(to view: SKView) {
        maxX = Double(screenSize.width - 10.0)
        minX = -1 * maxX
        maxY = Double(screenSize.height - 10.0)
        minY = -1 * maxY
        
        bubbleTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(createBubble), userInfo: nil, repeats: true)
    }
    
    @objc func createBubble() {
        let xPosition = Double.random(in: minX...maxX)
        let yPosition = Double.random(in: minY...maxY)
        let bubble = SKShapeNode.init(circleOfRadius: 10.0)
        bubble.fillColor = UIColor.black
        bubble.alpha = 1.0
        bubble.position = CGPoint(x: xPosition, y: yPosition)
        addChild(bubble)
    }
    
    func randomColor() {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
