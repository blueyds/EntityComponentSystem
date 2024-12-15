import SwiftMatrix
public protocol Renderer: AnyObject{
	
	func pushDebug(_ : String)
	func popDebug()
	func setModel(matrix: Matrix)
	func setView(matrix: Matrix)
	func setProjection(matrix: Matrix)
	func setVertex(_ : [Vertex])
	func drawPrimitives(count: Int)
}

