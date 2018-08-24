import UIKit
import SpriteKit

class DefendGameScene: SKScene {
    var gameVC: GameViewController?
    let ud = UserDefaults.standard
    private var bubblesPopped: Int = 0
    
    private let screenSize: CGRect = UIScreen.main.bounds
    private var maxX: Double = 0.0
    private var maxY: Double = 0.0
    
    override func didMove(to view: SKView) {
        maxX = Double(screenSize.width)
        maxY = Double(screenSize.height)
        
        bubblesPopped = 0
        addPlayer()
    }
    
    func addPlayer() {
        let playerSize = CGSize(width: 75, height: 75)
        let player = SKShapeNode(rectOf: playerSize, cornerRadius: 15.0)
        player.position = CGPoint(x: 0.0, y: 0.0)
        player.fillColor = UIColor.darkGray
        player.strokeColor = UIColor.clear
        player.alpha = 1.0
        self.addChild(player)
    }
    
    func addBubble() {
        let bubble = DefendBubble(circleOfRadius: 25.0)
        bubble.position = randomEdgePosition(width: maxX, height: maxY)
        bubble.isUserInteractionEnabled = true
        bubble.fillColor = randomColor()
        bubble.strokeColor = UIColor.clear
        bubble.alpha = 1.0
        self.addChild(bubble)
    }
}

class DefendBubble : SKShapeNode {
    
}
