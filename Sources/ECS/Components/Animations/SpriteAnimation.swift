//
//  SpriteAnimation.swift
//  ECSDemo
//
//  Created by Craig Nunemaker on 12/29/24.
//

import Foundation


public class SpriteAnimation: AnimationOverTime{
	public var duration: Duration

	public var startTime: SuspendingClock.Instant = SuspendingClock.now



	public var entity: (any Entity)!

	public static var typeID: Int = Manager.getNewComponentTypeID()

	private var animations: [RC] = []

	public init(row: Int, tiles: Int, duration: Duration){
		self.duration = duration
		addAnimations(row: row, tiles: tiles)
	}

	public func animate(progress: Float) {
		guard let sprite: SpriteComponent = getComponent(inEntity: entity) else {return}
		let slide = Int((Float(animations.count) * progress).rounded(.down))
		sprite.changeTexture(rcRef:  animations[slide])
	}


	private func addAnimations(row: Int, tiles: Int){
		for tile in 0..<tiles{
			animations.append(RC(row: row, column: 	tile))
		}

	}


}
