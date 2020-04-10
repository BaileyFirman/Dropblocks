//
//  Score.swift
//  Dropblocks
//
//  Created by Bailey Firman on 9/04/20.
//  Copyright © 2020 Bailey Firman. All rights reserved.
//

import Foundation
import SpriteKit

class Lives: InformationLabel {
    let indicatorPositions: [CGPoint]
    let indicators: [Indicator]
    let maximumLives: Int

    var lifes: Int {
        didSet {
            displayLives()
        }
    }

    init(positioning: PPositioning, maximumLives: Int) {
        self.maximumLives = maximumLives
        self.lifes = maximumLives
        self.indicatorPositions = Lives.buildPositions(positioning: positioning)
        self.indicators = indicatorPositions.map { Indicator(diameter: 10.0, origin: $0, color: SKColor.black) }
        displayLives()
    }

    private static func buildPositions(positioning: PPositioning) -> [CGPoint] {
        let yOffset = positioning.getDeviceheight() - positioning.getBlockSize().height

        let deviceWidth = positioning.getDeviceWidth()
        let xOffests = [0.45, 0.475, 0.5, 0.525, 0.55].map { deviceWidth * $0 - 5 }

        return xOffests.map { CGPoint(x: $0, y: yOffset) }
    }

    func increment() -> Int {
        self.lifes += 1
        return self.lifes
    }

    func decrement() -> Int {
        self.lifes -= 1
        return self.lifes
    }

    func reset() {
        lifes = maximumLives
    }

    func showLives(livesToDisplay: [Int]) {
        indicators.forEach { $0.isHidden = true }
        livesToDisplay.forEach { indicators[$0].isHidden = false }
    }

    func displayLives() {
        switch lifes {
        case 3:
            showLives(livesToDisplay: [0, 2, 4])
        case 2:
            showLives(livesToDisplay: [1, 3])
        case 1:
            showLives(livesToDisplay: [2])
        case 0:
            showLives(livesToDisplay: [])
        default:
            reset()
        }
    }
}

class Indicator: SKShapeNode {

    init(diameter: CGFloat, origin: CGPoint, color: SKColor) {
        super.init()

        let size = CGSize(width: diameter, height: diameter)
        self.path = CGPath(ellipseIn: CGRect(origin: origin, size: size), transform: nil)
        self.fillColor = color
        self.strokeColor = color
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
