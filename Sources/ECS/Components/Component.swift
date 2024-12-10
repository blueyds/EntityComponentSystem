public protocol Component: AnyObject{
	var entity: Entity? { get set}
	static var typeID: Int { get }
	func setup()
	func update()
	func draw(renderer: any Renderer)
}

extension Component{
	public func setup(){}
	public func update() {}
	public func draw(renderer: any Renderer){}
}

