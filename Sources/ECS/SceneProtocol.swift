//
//  SceneProtocol.swift
//  ECSMetalGameDemo
//
//  Created by Craig Nunemaker on 12/4/24.
//


import Foundation
import SwiftMatrix

public protocol SceneProtocol: AnyObject{

	var manager: Manager { get }
	var camera: (any Camera.CameraProtocol)? { get }
}

extension SceneProtocol{
	public func draw(renderer: any Renderer){
		renderer.pushDebug("SCENE")
		renderer.setView(matrix: camera?.viewMatrix ?? Matrix.identity)
		renderer.setProjection(matrix: camera?.projectionMatrix ?? Matrix.identity)
		manager.draw(renderer: renderer)
		renderer.popDebug()
	}

	public func update(){
		manager.update()
	}
}
