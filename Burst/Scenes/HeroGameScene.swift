import SpriteKit
import GameplayKit
import Foundation
import UIKit
import AVKit
import AudioToolbox

class HeroGameScene: GameScene {
    var currentPosition: Int = 0
    var nextNoteTimer: Timer?
    
    override func didMove(to view: SKView) {
        addBottomRow()
        playSong(song: song1)
    }
    
    func addBottomRow() {
        let radius = maxX / 6.0
        let ypos = (-1 * maxY) + radius
        var xpos = -5 * radius
        for _ in 1...6 {
            let bubble = Bubble(circleOfRadius: CGFloat(radius))
            bubble.position = CGPoint(x: xpos, y: ypos)
            bubble.isUserInteractionEnabled = false
            bubble.fillColor = UIColor.clear
            bubble.strokeColor = UIColor.black
            bubble.alpha = 1.0
            self.addChild(bubble)
            xpos += 2 * radius
        }
    }
    
    func playSong(song: Song) {
        nextNoteTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(addNote), userInfo: nil, repeats: true)
        currentPosition += 1
    }
    
    @objc func addNote() {
        let radius = maxX / 6.0
        let ypos = maxY
        var xpos = -5 * radius
        for _ in 0..<currentPosition - 1 {
            xpos += 2 * radius
        }
        let bubble = Bubble(circleOfRadius: CGFloat(radius))
        bubble.position = CGPoint(x: xpos, y: ypos)
        bubble.isUserInteractionEnabled = true
        bubble.fillColor = randomColor()
        bubble.strokeColor = UIColor.clear
        bubble.alpha = 1.0
        self.addChild(bubble)
        moveBubble(bubble: bubble)
    }
    
    @objc func moveBubble(bubble: Bubble) {
        let radius = CGFloat(maxX / 6.0)
        let newPosition = CGPoint(x: bubble.position.x, y: -1 * bubble.position.y + radius)
        let bubbleSpeed = 4.0 //tempo will be dependent on the song later
        let moveAction = SKAction.move(to: newPosition, duration: bubbleSpeed)
        bubble.run(moveAction)
    }
}
