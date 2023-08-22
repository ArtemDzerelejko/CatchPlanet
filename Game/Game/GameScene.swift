//
//  GameScene.swift
//  Game
//
//  Created by artem on 21.08.2023.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    var scoreLabel: SKLabelNode!
    var score = 0
    var squareFallDuration: TimeInterval = 4.0
    var squareImages: [UIImage] = [
        UIImage(named: "moon")!,
        UIImage(named: "globe")!,
        UIImage(named: "jupiter")!,
        UIImage(named: "sun")!
        // Додайте інші малюнки сюди
    ]

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white

        scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        scoreLabel.fontColor = SKColor.blue
        scoreLabel.zPosition = 1
        
        addChild(scoreLabel)

        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addSquaresFromSides), SKAction.wait(forDuration: 4.0)])))
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addSquaresFromTop), SKAction.wait(forDuration: 4.0)])))
    }
    
    func addSquaresFromSides() {
        let numberOfSquaresInGroup = 1
        
        for _ in 1...numberOfSquaresInGroup {
                let angle = CGFloat.random(in: -CGFloat.pi/4 ... CGFloat.pi/4) // Angle between -45 and 45 degrees
                let radius = size.height / 2

                let startX = size.width + radius * cos(angle)
                let startY = size.height / 2 + radius * sin(angle)

                let randomImage = squareImages.randomElement()!
                let squareSize = CGSize(width: 100, height: 100)
                let squareTexture = SKTexture(image: randomImage)
                let square = SKSpriteNode(texture: squareTexture, size: squareSize)

                square.position = CGPoint(x: startX, y: startY)
                addChild(square)

                let endX = -radius * cos(angle) // x-coordinate to reach on the left side
                let endY = size.height / 2 - radius * sin(angle) // y-coordinate to reach on the left side

            let waitAction = SKAction.wait(forDuration: 0.95)
                let moveAction = SKAction.move(to: CGPoint(x: endX, y: endY), duration: squareFallDuration)
                let rotateAction = SKAction.rotate(byAngle: .pi * 2, duration: squareFallDuration)
                let sequenceAction = SKAction.sequence([waitAction, SKAction.group([moveAction, rotateAction]), SKAction.removeFromParent()])

                square.run(sequenceAction)

                if score > 10 {
                    squareFallDuration /= 1.1
                }
            }
    }
    
    func addSquaresFromTop() {
        let numberOfSquaresInGroup = 1
        
        for _ in 1...numberOfSquaresInGroup {
            let randomX = CGFloat.random(in: 0..<size.width)
            let randomImage = squareImages.randomElement()!
            let squareSize = CGSize(width: 100, height: 100)
            let squareTexture = SKTexture(image: randomImage)
            let square = SKSpriteNode(texture: squareTexture, size: squareSize)
            
            square.position = CGPoint(x: randomX, y: size.height + squareSize.height / 2)
            addChild(square)
            
            let moveAction = SKAction.move(to: CGPoint(x: randomX, y: -squareSize.height / 2), duration: squareFallDuration)
            let rotateAction = SKAction.rotate(byAngle: .pi * 2, duration: squareFallDuration)
            
            square.run(SKAction.sequence([SKAction.group([moveAction, rotateAction]), SKAction.removeFromParent()]))
            
            if score > 10 {
                squareFallDuration /= 1
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = nodes(at: location)
            for node in nodes {
                if let square = node as? SKSpriteNode {
                    score += 1
                    scoreLabel.text = "Score: \(score)"
                    square.removeFromParent()
                }
            }
        }
    }
}
