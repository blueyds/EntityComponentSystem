//
//  Camera.swift
//  ECSMetalGameDemo
//
//  Created by Craig Nunemaker on 12/5/24.
//

import Foundation
import SwiftMatrix

public protocol Camera: Component{
	var viewMatrix: Matrix { get }
	var projectionMatrix: Matrix { get }
}


extension Camera{
	public var viewMatrix: Matrix { .identity }
	public var projectionMatrix: Matrix { .identity }
}
