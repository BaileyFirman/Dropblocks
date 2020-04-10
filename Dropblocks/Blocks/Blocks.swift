//
//  Blocks.swift
//  Dropblocks
//
//  Created by Bailey Firman on 4/04/20.
//  Copyright © 2020 Bailey Firman. All rights reserved.
//

import Foundation
import SpriteKit

enum BlockType {
    case baseBlock
    case dropBlock
}

class Block: SKSpriteNode, Comparable {
    var lane: Lane

    init(name: String, position: CGPoint, size: CGSize, lane: Lane) {
        let texture = SKTexture(imageNamed: name)
        self.lane = lane
        super.init(texture: texture, color: SKColor.init(), size: texture.size())
        self.name = name
        self.position = position
        self.size = size
        self.physicsBody = buildPhysicsBody(size: self.size)
    }

    required init?(coder aDecoder: NSCoder) {
        self.lane = Lane.center
        super.init(coder: aDecoder)
    }

    private func buildPhysicsBody(size: CGSize) -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody.isDynamic = true
        physicsBody.categoryBitMask = PhysicsCategory.block
        physicsBody.contactTestBitMask = PhysicsCategory.dropBlock
        physicsBody.collisionBitMask = PhysicsCategory.none

        return physicsBody
    }

    static func < (lhs: Block, rhs: Block) -> Bool {
        lhs.lane.rawValue < rhs.lane.rawValue
    }

    static func == (lhs: Block, rhs: Block) -> Bool {
        lhs.lane.rawValue == rhs.lane.rawValue
    }
}
