//
//  GameActions.swift
//  Dropblocks
//
//  Created by Bailey Firman on 9/04/20.
//  Copyright © 2020 Bailey Firman. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {

    func createAndDropFallingBlock() {
        let fallingBlock = DropBlock(positioning: positioning)
        addChild(fallingBlock)
        fallingBlock.dropBlock()
    }

    func swapPlayerBlocks(touch: UITouch) {
        let xPosition = touch.location(in: self).x
        let lane = xPosition < positioning.getDeviceWidth() * 0.5 ? Lane.left : Lane.right
        userBlocks.swapBlocks(lane: lane, positioning: positioning)
    }

    func resetGame() {
        self.timeLabel.reset()
        self.scoreLabel.reset()
        self.liveLabel.reset()
    }
}
