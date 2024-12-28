//
//  MetalRenderer.swift
//  ECSMetalGameDemo
//
//  Created by Craig Nunemaker on 12/8/24.
//

import Foundation
import MetalKit
import SwiftMatrix

public protocol MetalRenderer:Renderer{
	var device: MTLDevice? { get } // required
	var pixelFormat: MTLPixelFormat { get } //required
	var depthPixelFormat: MTLPixelFormat? { get } // required
	var rCE: MTLRenderCommandEncoder? { get set } // required
	var defaultRenderPipeline: MTLRenderPipelineState? { get } // required
	var defaultDepthStencilState: MTLDepthStencilState? { get } // required 
	var vertexBufferIndex: Int { get } // default implement = 0
	var modelMatrixIndex: Int { get } // default implemenkkt = 1
	var viewMatrixIndex: Int { get } // default implement = 2
	var projectionMatrixIndex: Int { get } // default implement = 3
	func makeLibrary()->MTLLibrary? // default implement provided
	func set(renderCommandEncoder : MTLRenderCommandEncoder?) // defult implement provided
}

// defualt implementations of some MetalRenderer requirements
extension MetalRenderer{

	public var vertexBufferIndex: Int { 0 }
	public var modelMatrixIndex: Int { 1 }
	public var viewMatrixIndex: Int { 2 }
	public var projectionMatrixIndex: Int { 3 }
	public var materialConstantsIndex: Int { 0 }
	
	public func makeLibrary()->MTLLibrary?{
		device?.makeDefaultLibrary()
	}
	
	public func set(renderCommandEncoder : MTLRenderCommandEncoder?){
		rCE = renderCommandEncoder
		if defaultRenderPipeline != nil {
			rCE?.setRenderPipelineState(defaultRenderPipeline!)
	}
		if defaultDepthStencilState != nil{
			rCE?.setDepthStencilState(defaultDepthStencilState!)
		}
	}
}

// default implementations of Renderer Protocol
extension MetalRenderer{
	public func pushDebug(_ named: String) {
		rCE!.pushDebugGroup(named)
	}
	
	public func popDebug() {
		rCE!.popDebugGroup()
	}
	
	
	public func setModel(matrix: Matrix) {
		var modelMatrix = matrix
		rCE!.setVertexBytes(&modelMatrix, length: Matrix.stride(), index: modelMatrixIndex)
	}
	
	public func setView(matrix: SwiftMatrix.Matrix) {
		var viewMatrix = matrix
		rCE!.setVertexBytes(&viewMatrix, length: Matrix.stride(), index: viewMatrixIndex)
	}
	
	public func setProjection(matrix: SwiftMatrix.Matrix) {
		var projectionMatrix = matrix
		rCE!.setVertexBytes(&projectionMatrix, length: Matrix.stride(), index: projectionMatrixIndex)
	}
	
	public func setVertex(_ verticeBytes: [Vertex]){
		var vertices = verticeBytes
		rCE!.setVertexBytes(&vertices, length: Vertex.stride(of: vertices.count), index: vertexBufferIndex)
	}
	
	public func setMaterial(constants: Material){
		var material: Material = constants
		rCE!.setFragmentBytes(&material, length: Material.stride(), index: materialConstantsIndex)
	}
	
	public func drawPrimitives(count: Int) {
		rCE!.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: count)
	}

	public func createRenderPipeline(vertexFn: String, fragmentFn: String)->MTLRenderPipelineState?{
		var result: MTLRenderPipelineState? = nil
		let library = makeLibrary()
		let vertexFunction = library!.makeFunction(name: vertexFn)
		let fragmentFunction = library!.makeFunction(name: fragmentFn)
		let renderPipelineDescriptore = MTLRenderPipelineDescriptor()
		renderPipelineDescriptore.colorAttachments[0].pixelFormat = pixelFormat
		if depthPixelFormat != nil{
			renderPipelineDescriptore.depthAttachmentPixelFormat = depthPixelFormat!
		}
		renderPipelineDescriptore.vertexFunction = vertexFunction
		renderPipelineDescriptore.fragmentFunction = fragmentFunction
		do{
			result = try device?.makeRenderPipelineState(descriptor: renderPipelineDescriptore)
		} catch let error as NSError{
			print(error)
		}
		return result
	}
	
	public func createDepthStencilState(compareFn: MTLCompareFunction)->MTLDepthStencilState?{
		let depthStencilDescriptor = MTLDepthStencilDescriptor()
		depthStencilDescriptor.isDepthWriteEnabled = true
		depthStencilDescriptor.depthCompareFunction = compareFn
		return device?.makeDepthStencilState(descriptor: depthStencilDescriptor)
	}
	
	
}

extension MetalRenderer{
	
}