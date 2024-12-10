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
	var device: (any MTLDevice)? { get }
	var pixelFormat: MTLPixelFormat { get }
	var depthPixelFormat: MTLPixelFormat? { get }
	var rCE: MTLRenderCommandEncoder? { get set }
	var defaultRenderPipeline: MTLRenderPipelineState? { get }
	var defaultDepthStencilState: MTLDepthStencilState? { get }
	var vertexBufferIndex: Int { get }
	var modelMatrixIndex: Int { get }
	var viewMatrixIndex: Int { get }
	var projectionMatrixIndex: Int { get }
	func makeLibrary()->MTLLibrary?
	func set(renderCommandEncoder : MTLRenderCommandEncoder?)

}
extension MetalRenderer{

	public var vertexBufferIndex: Int { 0 }
	public var modelMatrixIndex: Int { 1 }
	public var viewMatrixIndex: Int { 2 }
	public var projectionMatrixIndex: Int { 3 }
	
	public func pushDebug(_ named: String) {
		rCE!.pushDebugGroup(named)
	}
	
	public func popDebug() {
		rCE!.popDebugGroup()
	}
	
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
	
	public func setVertex(_ verticeBytes: [V]){
		var vertices = verticeBytes
		rCE!.setVertexBytes(&vertices, length: V.stride(of: vertices.count), index: vertexBufferIndex)
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
