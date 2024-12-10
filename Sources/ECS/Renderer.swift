import SwiftMatrix
public protocol Renderer{
	associatedtype V: VertexProtocol
	func pushDebug(_ msg: String)
	func popDebug()
	func setModel(matrix: Matrix)
	func setView(matrix: Matrix)
	func setVertex(_ : V)
	func drawPrimitives(count: Int)
}

