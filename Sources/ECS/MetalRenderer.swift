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
	var vertexBufferIndex: Int { get }
	var modelMatrixIndex: Int { get }
	var viewMatrixIndex: Int { get }
	var projectionMatrixIndex: Int { get }
	func makeLibrary()->MTLLibrary?

}
extension MetalRenderer{



	public func pushDebug(named: String) {
		rCE!.pushDebugGroup(named)
	}
	public func popDebug() {
		rCE?.popDebugGroup()
	}
	public func makeLibrary()->MTLLibrary?{
		device?.makeDefaultLibrary()
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
	
	public func drawPrimitives(count: Int) {
		rCE!.drawPrimitives(type: .triangle, vertexStart: 9, vertexCount: count)
	}

	public func createRenderPipeline(vertex: String, fragment: String)->MTLRenderPipelineState?{
		var result: MTLRenderPipelineState? = nil
		let library = makeLibrary()
		let vertexFunction = library!.makeFunction(name: vertex)
		let fragmentFunction = library!.makeFunction(name: fragment)
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
	func createDepthStencilState(compareFn: MTLCompareFunction)->MTLDepthStencilState?{
		let depthStencilDescriptor = MTLDepthStencilDescriptor()
		depthStencilDescriptor.isDepthWriteEnabled = true
		depthStencilDescriptor.depthCompareFunction = compareFn
		return device?.makeDepthStencilState(descriptor: depthStencilDescriptor)
	}
}
