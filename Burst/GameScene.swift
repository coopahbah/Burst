import SpriteKit
import GameplayKit
import Darwin

class GameScene: SKScene {
    private let screenSize = UIScreen.main.bounds
    
    override func didMove(to view: SKView) {
        createBubble()
    }
    
    func createBubble() {
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let maxX = Double(screenWidth - 10.0)
        let minX = -1 * maxX
        let maxY = Double(screenHeight - 10.0)
        let minY = -1 * maxY
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
