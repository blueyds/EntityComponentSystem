import SwiftMatrix
import simd
public class TransformComponent: Component{
	public var entity: Entity? = nil
	static public var typeID: Int = Manager.getNewComponentTypeID()
	
	public var position: SIMD3<Float> = .zero
	public var rotation: SIMD3<Float> = .zero
	public var scale: SIMD3<Float> = .one
	
	
	public init(){}
	
	public init(x: Float, y: Float){
		position = SIMD3(x, y, 0)
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

// common matrices
extension TransformComponent{
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
}

// common manipulations
extension TransformComponent{

	public func moveBy(x: Float, y: Float, z: Float = 0){
		position.x += x
		position.y += y
		position.z += z
	}
}




