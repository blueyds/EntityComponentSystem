//
//  Vertex.swift
//  ECSMetalGameDemo
//
//  Created by Craig Nunemaker on 12/8/24.
//

import Foundation
import simd
import Sizeable

public struct Vertex{
	public let position: SIMD3<Float>
	public let color: SIMD4<Float>
	public let texCoord: SIMD2<Float>

	public init(x: Float, y: Float, u: Float, v: Float, color: SIMD4<Float>){
		position = SIMD3(x, y, 0)
		texCoord = SIMD2(u, v)
		self.color = color
	}
	public init(){
		position = .zero
		color = SIMD4(0,0,0,1)
		texCoord = .zero
	}
}

extension Vertex: sizeable{ }
