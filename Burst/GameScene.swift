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
        bubble.fillColor = randomColor()
        bubble.alpha = 1.0
        bubble.position = CGPoint(x: xPosition, y: yPosition)
        addChild(bubble)
    }
    
    func randomColor() -> UIColor! {
        let redContent = CGFloat.random(in: 0.0...1.0)
        let greenContent = CGFloat.random(in: 0.0...1.0)
        let blueContent = CGFloat.random(in: 0.0...1.0)
        return UIColor(red: redContent, green: greenContent, blue: blueContent, alpha: 1.0)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
