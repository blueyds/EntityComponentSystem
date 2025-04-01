public protocol Component: AnyObject{
	var entity: (any Entity)! { get set}
	static var typeID: Int { get }
	func setup()
	func destroy()
	func update()
	func draw(renderer: any Renderer)
}

extension Component{
	public func setup(){}
	public func destroy() {}
	public func update() {}
	public func draw(renderer: any Renderer){}
}

