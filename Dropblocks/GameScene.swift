//
//  GameScene.swift
//  Dropblocks
//
//  Created by Bailey Firman on 4/04/20.
//  Copyright © 2020 Bailey Firman. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()

    let positioning: PPositioning
    var userBlocks: PlayerBlocks

    var scoreLabel: InformationLabel
    var timeLabel: InformationLabel
    var liveLabel: Lives

    var lastUpdateTime: TimeInterval = 0

    override init(size: CGSize) {
        self.positioning = Positioning()
        self.userBlocks = BaseBlocks(positioning: positioning)
        self.scoreLabel = ScoreLabel(positioning: positioning)
        self.timeLabel = TimeLabel(positioning: positioning)

        self.liveLabel = Lives(positioning: positioning, maximumLives: 3)
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        self.positioning = Positioning()
        self.userBlocks = BaseBlocks(positioning: positioning)
        self.scoreLabel = ScoreLabel(positioning: positioning)
        self.timeLabel = TimeLabel(positioning: positioning)
        self.liveLabel = Lives(positioning: positioning, maximumLives: 3)
        super.init(coder: aDecoder)
    }

    override func sceneDidLoad() {
    }

    private func initalizeWorld() {
        backgroundColor = SKColor.white
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }

    private func initalizePlayerBlocks() {
        userBlocks.getBlocks().forEach { (baseBlock) in
            addChild(baseBlock)
        }
        addChild(userBlocks.getBaseObscurer())
    }

    private func initalizeLiveIndicators() {
        liveLabel.indicators.forEach { (indicator) in
            addChild(indicator)
        }
    }

    private func initalizeLabels() {
        guard let score = scoreLabel as? SKNode, let time = timeLabel as? SKNode else {
            return
        }
        addChild(time)
        addChild(score)
    }

    private func incrementGameTime() {
        _ = timeLabel.increment()
    }

    override func didMove(to view: SKView) {
        initalizeWorld()
        initalizePlayerBlocks()
        initalizeLabels()
        initalizeLiveIndicators()

        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(createAndDropFallingBlock),
                SKAction.wait(forDuration: 0.8),
                SKAction.run(incrementGameTime)
            ])
        ))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            swapPlayerBlocks(touch: touch)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        if self.lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }

        let deltaTime = currentTime - self.lastUpdateTime
        for entity in self.entities {
            entity.update(deltaTime: deltaTime)
        }
        self.lastUpdateTime = currentTime
    }
}
