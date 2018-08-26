import SpriteKit
import GameplayKit
import Foundation
import UIKit
import AVKit

/*
 -popping sound
 -color themes
 -different game modes
    -classic
        -Expert Mode: multiple bubbles spawn at once
    -bubbles appear at edge and attack ship in center
        -Expert Mode: bubbles move in circles with player as "planet"
    -bubbles stay same size, ends when too many
 -improve UI
 */

var gameVC: GameViewController?

func randomBool() -> Bool {
    let rand = arc4random() % 2
    return rand == 1
}

func randomDouble(upper: Double) -> Double {
    let magnitude = drand48() * upper
    if (!randomBool()) {
        return -1 * magnitude
    }
    return magnitude
}

func randomColor() -> UIColor! {
    let redContent = CGFloat(drand48())
    let greenContent = CGFloat(drand48())
    let blueContent = CGFloat(drand48())
    return UIColor(red: redContent, green: greenContent, blue: blueContent, alpha: 1.0)
}

func randomEdgePosition(width: Double, height: Double) -> CGPoint {
    var pointX: Double? = nil
    var pointY: Double? = nil
    if (randomBool()) {
        pointX = width
        if (randomBool()) {
            pointX = pointX! * -1.0
        }
    } else {
        pointY = height
        if (randomBool()) {
            pointY = pointY! * -1.0
        }
    }
    if (pointX == nil) {
        pointX = randomDouble(upper: width)
    }
    if pointY == nil {
        pointY = randomDouble(upper: height)
    }
    return CGPoint(x: pointX!, y: pointY!)
}
