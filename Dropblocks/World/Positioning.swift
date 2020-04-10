//
//  Positioning.swift
//  Dropblocks
//
//  Created by Bailey Firman on 4/04/20.
//  Copyright © 2020 Bailey Firman. All rights reserved.
//

import Foundation
import SpriteKit

private struct Device {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
}

private struct BlockDimensions {
    let width: CGFloat
    let height: CGFloat
    let size: CGSize

    init(device: Device) {
        width = device.width / 3
        height = device.height / 18
        size = CGSize(width: self.width, height: self.height * 2)
    }
}

private struct BlockPostioning {
    let left: CGPoint
    let center: CGPoint
    let right: CGPoint

    init(block: BlockDimensions) {
        let leftOffset = block.width / 2
        let centreOffset = block.width / 2 + block.width
        let rightOffset = block.width / 2 + block.width * 2

        left = CGPoint(x: leftOffset, y: block.height)
        center = CGPoint(x: centreOffset, y: block.height)
        right = CGPoint(x: rightOffset, y: block.height)
    }
}

protocol PPositioning {
    func getDeviceWidth() -> CGFloat
    func getDeviceheight() -> CGFloat
    func getLane(lane: Lane) -> CGPoint
    func getBlockSize() -> CGSize
}

enum Lane: Int {
    case left = 0
    case center = 1
    case right = 2
}

enum DeviceSide {
    case left
    case right
}

class Positioning: PPositioning {

    private let device: Device
    private let block: BlockDimensions
    private let blockPositioning: BlockPostioning

    init() {
        self.device = Device()
        self.block = BlockDimensions(device: self.device)
        self.blockPositioning = BlockPostioning(block: self.block)
    }

    func getLane(lane: Lane) -> CGPoint {
        let lanes = getLanes()
        switch lane {
        case Lane.left:
            return lanes[0]
        case Lane.center:
            return lanes[1]
        case Lane.right:
            return lanes[2]

        }
    }

    func getLanes() -> [CGPoint] {
        return [blockPositioning.left, blockPositioning.center, blockPositioning.right]
    }

    func getBlockSize() -> CGSize {
        return block.size
    }

    func getDeviceheight() -> CGFloat {
        return device.height
    }

    func getDeviceWidth() -> CGFloat {
        return device.width
    }
}
