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
	//var transform: TransformComponent? { get set }
	func buildVertices()
}
extension CustomMeshComponent {
	public func setup() {
		buildVertices()
	}
	public func draw(renderer: any Renderer){
		renderer.pushDebug("TypeID \(Self.typeID)")
		let transform: TransformComponent? = entity?.getComponent()
		renderer.setModel(matrix: transform?.modelMatrix  ?? .identity)
		renderer.setVertex(vertices)
		renderer.setMaterial(constants: Material())
		renderer.drawPrimitives(count: vertices.count)
		renderer.popDebug()
	}
	public func add(vertex: Vertex){
		vertices.append(vertex)
	}
}
