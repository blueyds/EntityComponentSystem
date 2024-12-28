//
//  TriangleComponent.swift
//  ECSMetalGameDemo
//
//  Created by Craig Nunemaker on 12/4/24.
//

import Foundation

public class CustomTriangleComponent: CustomMeshComponent {
	
	public var vertices: [Vertex] = []

	public var material: Material = Material()
	public var entity: Entity? = nil

	public static var typeID: Int = Manager.getNewComponentTypeID()

	public init(color: SIMD4<Float>){
		material.color = color
	}


}

extension CustomTriangleComponent{
	public func buildVertices(){
		add(vertex: Vertex(x:  0.0, y:  0.5, u: 0.5, v: 0, color: .black)) // TOP
		add(vertex: Vertex(x:  0.5, y: -0.5, u: 1.0, v: 1, color: .black)) // BR
		add(vertex: Vertex(x: -0.5, y: -0.5, u: 0.0, v: 1, color: .black)) // BL
	}
}
