import Foundation
import simd


public class CustomQuadComponent: CustomMeshComponent{
	public var vertices: [Vertex] = []
	
	public var transform: TransformComponent? = nil

	public var entity: Entity? = nil

	public let color: SIMD4<Float>

	public static var typeID: Int = Manager.getNewComponentTypeID()

	public init(color: SIMD4<Float>){
		self.color = color
	}



}

extension CustomQuadComponent{
	public func buildVertices(){
		add(vertex: Vertex(x: -0.5, y:  0.5, u: 0, v: 0, color: color)) // TL
		add(vertex: Vertex(x:  0.5, y:  0.5, u: 1, v: 0, color: color)) // TR
		add(vertex: Vertex(x: -0.5, y: -0.5, u: 0, v: 1, color: color)) // BL
		add(vertex: Vertex(x: -0.5, y: -0.5, u: 0, v: 1, color: color)) // BL
		add(vertex: Vertex(x:  0.5, y:  0.5, u: 1, v: 0, color: color)) // TR
		add(vertex: Vertex(x:  0.5, y: -0.5, u: 1, v: 1, color: color)) // BR
	}

}
