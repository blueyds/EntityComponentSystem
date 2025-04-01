//
//  VertexCollectionProtocol.swift
//  ECSMetalGameDemo
//
//  Created by Craig Nunemaker on 12/4/24.
//

import Foundation
import SwiftMatrix

public protocol CustomMeshComponent: Component {

	var vertices: [Vertex] { get set}
	var material: Material { get set }
	//var transform: TransformComponent? { get set }
	func buildVertices()
}
extension CustomMeshComponent {
	public func setup() {
		buildVertices()
	}
	public func change(color: SIMD4<Float>){
		material.color = color
	}
	public func draw(renderer: any Renderer){
		guard let transform: TransformComponent = getComponentIn(entity: entity) else { return }

		renderer.pushDebug("TypeID \(Self.typeID)")
		
		renderer.setModel(matrix: transform.modelMatrix)
		renderer.setVertex(vertices)
		renderer.setMaterial(constants: material)
		renderer.drawPrimitives(count: vertices.count)
		
		renderer.popDebug()
	}
	public func add(vertex: Vertex){
		vertices.append(vertex)
	}
}
