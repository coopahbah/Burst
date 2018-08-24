import SpriteKit
import GameplayKit
import Foundation
import UIKit

var gameVC: GameViewController?

func randomDouble(upper: Double) -> Double {
    let magnitude = drand48() * upper
    let positiveInt = arc4random() % 2
    let positive: Bool = positiveInt == 1
    if (!positive) {
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
