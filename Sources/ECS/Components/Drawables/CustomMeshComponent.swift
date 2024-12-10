//
//  VertexCollectionProtocol.swift
//  ECSMetalGameDemo
//
//  Created by Craig Nunemaker on 12/4/24.
//

import Foundation
public protocol CustomMeshComponent: Component {
	associatedtype R: Renderer
	var vertices: [R.V] { get }
	var transform: TransformComponent? { get set }
	func buildVertices()
}
extension CustomMeshComponent {
	public typealias V = R.V
	public func setup() {
		transform = entity?.get()
		buildVertices()
	}
	public func draw(renderer: R){
		
		renderer.pushDebug("TypeID \(Self.typeID)")
		renderer.setModel(matrix: transform?.modelMatrix  ?? matrix_identity_float4x4)
		renderer.setVertex(vertices: vertices)
		renderer.drawPrimitives(count: vertices.count)
		renderer.popDebug()
	}
}
