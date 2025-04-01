//
//  File.swift
//  ECS
//
//  Created by Craig Nunemaker on 12/14/24.
//

import Foundation
import SwiftMatrix

extension Camera{
	public class ScaledProjection: CameraProtocol{
		public var entity: (any Entity)? = nil

		public static var typeID: Int = Manager.getNewComponentTypeID()
		
		public var projectionScale: SIMD3<Float>

		public init(scaledBy: SIMD3<Float>){
			self.projectionScale = scaledBy
		}
		
		
		public var projectionMatrix: Matrix{
			var result: Matrix = .identity
			result.scale(projectionScale)
			return result
		}
	}
}
