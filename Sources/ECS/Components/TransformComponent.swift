import simd
public class TransformComponent: Component{
	public var entity: Entity? = nil
	static public var typeID: Int = Manager.getNewComponentTypeID()
	var transforms: TransformData = TransformData()
	var modelMatrix: Matrix { transforms?.modelMatrix ?? .identity}

}



