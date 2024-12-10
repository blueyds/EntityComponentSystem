public protocol Component: AnyObject{
	associatedtype R: Renderer
	var entity: Entity? { get set}
	static var typeID: Int { get }
	func setup()
	func update()
	func draw(renderer: R)
}

extension Component{
	public typealias V = R.V
	public func setup(){}
	public func update() {}
	public func draw(renderer: R){}
}

