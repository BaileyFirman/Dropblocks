//
//  DropBlock.swift
//  Dropblocks
//
//  Created by Bailey Firman on 8/04/20.
//  Copyright © 2020 Bailey Firman. All rights reserved.
//

import Foundation
import SpriteKit

class DropBlock: Block {
    let colors = ["red", "green", "blue"]
    let type = BlockType.dropBlock

    init(positioning: PPositioning) {
        let name = self.colors[Random.randomIndex(3)]
        let blockSize = positioning.getBlockSize()

        let laneIndex = Random.randomIndex(3)
        let lane = Lane(rawValue: laneIndex) ?? Lane.center
        let initialPositionX = positioning.getLane(lane: lane ).x
        let initialPositionY = positioning.getDeviceheight() - blockSize.height * 2

        let position = CGPoint(x: initialPositionX, y: initialPositionY)
        let size = CGSize(width: blockSize.width, height: blockSize.height * 0.25)

        super.init(name: name, position: position, size: size, lane: lane)

        self.physicsBody?.categoryBitMask = PhysicsCategory.dropBlock
        self.physicsBody?.contactTestBitMask = PhysicsCategory.block
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func fallingAction(duration: CGFloat) -> SKAction {
        return SKAction.move(to: CGPoint(x: self.position.x, y: 0), duration: TimeInterval(duration))
    }

    func dropBlock() {
        let randomDuration = Random.randomFloatInRange(min: CGFloat(1.5), max: CGFloat(2))
        let actionMove = self.fallingAction(duration: randomDuration)
        let actionMoveDone = SKAction.removeFromParent()
        self.run(SKAction.sequence([actionMove, actionMoveDone]))
    }

    func hide() {
        self.zPosition = -2
    }
}
