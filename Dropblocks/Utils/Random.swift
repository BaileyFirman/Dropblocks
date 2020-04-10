//
//  Random.swift
//  Dropblocks
//
//  Created by Bailey Firman on 8/04/20.
//  Copyright © 2020 Bailey Firman. All rights reserved.
//

import Foundation
import SpriteKit

class Random {
    static func random() -> CGFloat {
        let randomDivisor: Float = 4294967296
        return CGFloat(Float(arc4random()) / randomDivisor)
    }

    static func randomFloatInRange(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }

    static func randomIndex(_ max: Int) -> Int {
        return Int.random(in: 0..<max)
    }
}
