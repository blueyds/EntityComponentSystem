import Foundation
import simd


public class CustomQuadComponent: CustomMeshComponent{
	public var vertices: [Vertex] = []
	
	public var entity: (any Entity)? = nil

	public var material: Material = Material()

	public static var typeID: Int = Manager.getNewComponentTypeID()

	public init(color: SIMD4<Float>){
		material.color = color
	}



}

extension CustomQuadComponent{
	public func buildVertices(){
		add(vertex: Vertex(x: -0.5, y:  0.5, u: 0, v: 0, color: SIMD4(0.0, 0.0, 0.0, 1.0))) // TL
		add(vertex: Vertex(x:  0.5, y:  0.5, u: 1, v: 0, color: SIMD4(0.0, 0.0, 0.0, 1.0))) // TR
		add(vertex: Vertex(x: -0.5, y: -0.5, u: 0, v: 1, color: SIMD4(0.0, 0.0, 0.0, 1.0))) // BL
		add(vertex: Vertex(x: -0.5, y: -0.5, u: 0, v: 1, color: SIMD4(0.0, 0.0, 0.0, 1.0))) // BL
		add(vertex: Vertex(x:  0.5, y:  0.5, u: 1, v: 0, color: SIMD4(0.0, 0.0, 0.0, 1.0))) // TR
		add(vertex: Vertex(x:  0.5, y: -0.5, u: 1, v: 1, color: SIMD4(0.0, 0.0, 0.0, 1.0))) // BR
	}

}
