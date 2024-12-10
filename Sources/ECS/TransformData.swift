import simd
import SwiftMatrix

public struct TransformData{
	public var position: SIMD3<Float> = .zero
	public var rotation: SIMD3<Float> = .zero
	public var scale: SIMD3<Float> = .one
	public var modelMatrix: Matrix{
		var result: Matrix = .identity
		result.translateModel(position)
		result.rotate(rotation)
		result.scale(scale)
		return result
	}
	
	public var viewMatrix: Matrix{
		var result: Matrix = .identity
		result.translateModel(-position)
		result.rotate(rotation)
		result.scale(scale)
		return result
	}
	
	public init(x: Float, y: Float, z: Float){
		position = SIMD3(x, y, z)
	}
	public init(position: SIMD3<Float> = .zero, rotation: SIMD3<Float> = .zero, scale: SIMD3<Float> = .one){
		self.position = position
		self.rotation = rotation
		self.scale = scale
	}
}