import simd
public class TransformComponent: Component{
	var entity: Entity? = nil
	static public var typeID: Int = Manager.GetNewComponentTypeID()
	var transforms: TransformData
	var modelMatrix: Matrix { transforms?.modelMatrix ?? .identity}

}



