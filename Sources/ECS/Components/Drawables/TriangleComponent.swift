//
//  TriangleComponent.swift
//  ECSMetalGameDemo
//
//  Created by Craig Nunemaker on 12/4/24.
//

import Foundation

public protocol CustomTriangleComponent: CustomMeshComponent {}

extension CustomTriangleComponent{
	public func buildVertices(){
		vertices.append(V(x:  0.0, y:  0.5, u: 0.5, v: 0, color: color)) // TOP
		vertices.append(V(x:  0.5, y: -0.5, u: 1.0, v: 1, color: color)) // BR
		vertices.append(V(x: -0.5, y: -0.5, u: 0.0, v: 1, color: color)) // BL
	}
}
