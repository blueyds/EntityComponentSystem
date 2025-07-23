import SwiftMatrix
public protocol Renderer: AnyObject{
	
	func pushDebug(_ : String)
	func popDebug()
	func setModel(matrix: Matrix)
	func setView(matrix: Matrix)
	func setProjection(matrix: Matrix)
	func setVertex(_ : [Vertex])
	func setTexture(id: Int)
	func setMaterial(constants: Material)
	func drawPrimitives(count: Int)
	func setTexture(id: Int)
	
}


