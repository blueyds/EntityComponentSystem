import SwiftMatrix
public protocol Renderer: AnyObject{
	associatedtype V: VertexProtocol
	func pushDebug(_ : String)
	func popDebug()
	func setModel(matrix: Matrix)
	func setView(matrix: Matrix)
	func setProjection(matrix: Matrix)
	func setVertex(_ : [V])
	func drawPrimitives(count: Int)
}

