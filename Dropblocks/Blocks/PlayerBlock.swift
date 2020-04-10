//
//  PlayerBlock.swift
//  Dropblocks
//
//  Created by Bailey Firman on 8/04/20.
//  Copyright © 2020 Bailey Firman. All rights reserved.
//

import Foundation
import SpriteKit

protocol PlayerBlocks {
    func getBlocks() -> [Block]
    func swapBlocks(lane: Lane, positioning: PPositioning)
    func getBaseObscurer() -> SKShapeNode
}

class BaseBlocks: PlayerBlocks {
    var userBlocks: [Block]
    var redBlock: Block
    var blueBlock: Block
    var greenBlock: Block
    var obscurer: Obscurer

    init(positioning: PPositioning) {
        let leftPosition = positioning.getLane(lane: Lane.left)
        let centerPosition = positioning.getLane(lane: Lane.center)
        let rightPosition = positioning.getLane(lane: Lane.right)
        let blockSize = positioning.getBlockSize()

        let redBlock = Block(name: "red", position: leftPosition, size: blockSize, lane: Lane.left)
        let greenBlock = Block(name: "green", position: centerPosition, size: blockSize, lane: Lane.center)
        let blueBlock = Block(name: "blue", position: rightPosition, size: blockSize, lane: Lane.right)

        self.userBlocks = [redBlock, greenBlock, blueBlock]
        self.redBlock = redBlock
        self.blueBlock = blueBlock
        self.greenBlock = greenBlock

        self.obscurer = Obscurer(positioning: positioning)
    }

    func getBlocks() -> [Block] {
        return [redBlock, greenBlock, blueBlock]
    }

    func performBaseBlockSwap(node: SKNode, timeInterval: Double, endPoint: CGPoint ) {
        node.run(SKAction.move(to: endPoint, duration: timeInterval))
    }

    func swapBlocks(lane: Lane, positioning: PPositioning) {
        let duration = 0.15

        let blocks = getBlocks()

        guard let outerBlock = blocks.first(where: {$0.lane == lane}),
            let centerBlock = blocks.first(where: {$0.lane == Lane.center}) else {
            return
        }

        outerBlock.lane = Lane.center
        centerBlock.lane = lane

        performBaseBlockSwap(node: outerBlock, timeInterval: duration, endPoint: positioning.getLane(lane: Lane.center))
        performBaseBlockSwap(node: centerBlock, timeInterval: duration, endPoint: positioning.getLane(lane: lane))
    }

    func getBaseObscurer() -> SKShapeNode {
        return self.obscurer as SKShapeNode
    }
}

class Obscurer: SKShapeNode {

    init(positioning: PPositioning) {
        let blockSize = positioning.getBlockSize()
        let leftLanePosition = positioning.getLane(lane: Lane.left)
        let size = CGSize(width: blockSize.width * 3, height: blockSize.height)
        let position = CGPoint(x: leftLanePosition.x - blockSize.width, y: leftLanePosition.y - blockSize.height)

        super.init()
        self.path = CGPath(rect: CGRect(origin: positioning.getLane(lane: Lane.left), size: size), transform: nil)
        self.position = position
        self.zPosition = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
