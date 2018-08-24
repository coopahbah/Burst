import UIKit
import SpriteKit

class DefendGameScene: SKScene {
    var gameVC: GameViewController?
    let ud = UserDefaults.standard
    private var bubblesPopped: Int = 0
    
    private let screenSize: CGRect = UIScreen.main.bounds
    private var maxX: Double = 0.0
    private var minX: Double = 0.0
    private var maxY: Double = 0.0
    private var minY: Double = 0.0
    
    override func didMove(to view: SKView) {
        maxX = Double(screenSize.width)
        minX = -1 * maxX
        maxY = Double(screenSize.height)
        minY = -1 * maxY
        
        bubblesPopped = 0
        addPlayer()
    }
    
    func addPlayer() {
        let playerSize = CGSize(width: 20, height: 20)
        let player = SKShapeNode(rectOf: playerSize, cornerRadius: 5.0)
        player.position = CGPoint(x: 0.0, y: 0.0)
        player.fillColor = randomColor()
        player.strokeColor = UIColor.clear
        player.alpha = 1.0
        self.addChild(player)
    }
}
