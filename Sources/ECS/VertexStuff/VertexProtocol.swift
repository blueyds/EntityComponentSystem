import Sizeable

public protocol VertexProtocol: sizeable{
	init(x: Float, y: Float, u: Float, v: Float, color: SIMD4<Float>)
}