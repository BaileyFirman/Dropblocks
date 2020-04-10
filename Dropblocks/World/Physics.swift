//
//  Physics.swift
//  Dropblocks
//
//  Created by Bailey Firman on 4/04/20.
//  Copyright © 2020 Bailey Firman. All rights reserved.
//

import Foundation
import SpriteKit

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let all: UInt32 = UInt32.max
    static let block: UInt32 = 0b01
    static let dropBlock: UInt32 = 0b10
}

extension GameScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        evaluateContact(contact)
    }

    private func evaluateContact(_ contact: SKPhysicsContact) {
        contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
            ? evaluateColision(firstBody: contact.bodyA, secondBody: contact.bodyB)
            : evaluateColision(firstBody: contact.bodyB, secondBody: contact.bodyA)
    }

    private func evaluateColision(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody) {

        if firstBody.contactTestBitMask & PhysicsCategory.dropBlock != 0 &&
            secondBody.contactTestBitMask & PhysicsCategory.block != 0 {
            if let playerBlock = firstBody.node as? Block,
                let dropBlock = secondBody.node as? DropBlock {
                evaluateLane(playerBlock: playerBlock, dropBlock: dropBlock)
            }
        }
    }

    private func evaluateLane(playerBlock: Block, dropBlock: DropBlock) {
        if playerBlock.lane == dropBlock.lane {
            if playerBlock.name == dropBlock.name {
                dropBlock.removeFromParent()
                _ = scoreLabel.increment()
            } else {
                let livesRemaining = liveLabel.decrement()
                dropBlock.hide()
                if livesRemaining == 0 {
                    self.resetGame()
                }
            }
        }
    }
}
