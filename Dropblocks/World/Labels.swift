//
//  Labels.swift
//  Dropblocks
//
//  Created by Bailey Firman on 9/04/20.
//  Copyright © 2020 Bailey Firman. All rights reserved.
//

import Foundation
import SpriteKit

protocol InformationLabel {
    func increment() -> Int
    func decrement() -> Int
    func reset()
}

class Label: SKLabelNode {
    init(text: String, position: CGPoint) {
        super.init()
        self.text = text
        self.position = position
        self.fontName = "Menlo"
        self.fontSize = 16
        self.fontColor = UIColor(rgb: 0x0D0D10)
        self.horizontalAlignmentMode = .left
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ScoreLabel: Label, InformationLabel {
    var score = 0 {
        didSet {
            self.text = "Score \(score)"
        }
    }

    init(positioning: PPositioning) {
        let labelPositionX = positioning.getDeviceWidth() * 0.65
        let labelPositionY = positioning.getDeviceheight() - positioning.getBlockSize().height
        let labelPosition = CGPoint(x: labelPositionX, y: labelPositionY)
        super.init(text: "Score \(score)", position: labelPosition)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func increment() -> Int {
        self.score += 1
        return self.score
    }

    func decrement() -> Int {
        self.score -= 1
        return self.score
    }

    func reset() {
        self.score = 0
    }
}

class TimeLabel: Label, InformationLabel {
    var time = 0 {
        didSet {
            self.text = "Time \(time)"
        }
    }

    init(positioning: PPositioning) {
        let labelPositionX = positioning.getDeviceWidth() * 0.2
        let labelPositionY = positioning.getDeviceheight() - positioning.getBlockSize().height
        let labelPosition = CGPoint(x: labelPositionX, y: labelPositionY)
        super.init(text: "Time \(time)", position: labelPosition)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func increment() -> Int {
        self.time += 1
        return self.time
    }

    func decrement() -> Int {
        self.time -= 1
        return self.time
    }

    func reset() {
        time = 0
    }
}
