//
//  Camera.swift
//  ECSMetalGameDemo
//
//  Created by Craig Nunemaker on 12/5/24.
//

import Foundation
import SwiftMatrix
public enum Camera{
	public protocol CameraProtocol: Component{
		var viewMatrix: Matrix { get }
		var projectionMatrix: Matrix { get }
	}




}
extension Camera.CameraProtocol{
	public var viewMatrix: Matrix { .identity }
	public var projectionMatrix: Matrix { .identity }
}
