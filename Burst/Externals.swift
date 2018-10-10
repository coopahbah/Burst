import SpriteKit
import GameplayKit
import Foundation
import UIKit
import AVKit

/*
 -color themes
 -different game modes
 -Classic expert mode
 -bubbles stay same size, ends when too many
 -improve UI
 */

var gameVC: GameViewController?
var bubblesPopped: Int = 0

func randomBool() -> Bool {
    return Bool.random()
}

func randomDouble(upper: Double) -> Double {
    let numrange = Range(uncheckedBounds: (-1.0 * upper, upper))
    return Double.random(in: numrange)
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
