import SwiftMatrix
import simd
public class TransformComponent: Component{
	public var entity: Entity? = nil
	static public var typeID: Int = Manager.getNewComponentTypeID()
	var transforms: TransformData = TransformData()
	var modelMatrix: Matrix { transforms.modelMatrix }
	public init(){}
	public init(x: Float, y: Float){
		transforms.position = SIMD3(x, y, 0)
	}
	public init(x: Float, y: Float, z: Float){
		transforms.position = SIMD3(x, y, z)
	}
}



