// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "ECS",
	products: [
	// Products define the executables and libraries a package produces, making them visible to other packages.
		.library( name: "ECS", targets: ["ECS"])
	],
	dependencies:[
		.package(url: "https://github.com/blueyds/Sizeable", from:"1.0"),  
		.package(url: "https://github.com/blueyds/SwiftMatrix", from: "1.0")
	],
	targets: [
	// Targets are the basic building blocks of a package, defining a module or a test suite.
	// Targets can depend on other targets in this package and products from dependencies.
		.target(name: "ECS", dependencies: ["Sizeable", "SwiftMatrix"]), 
		.testTarget(name: "ECSTests", dependencies: ["ECS"])
	]
)

