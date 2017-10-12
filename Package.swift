// swift-tools-version:4.0
//
//  Package.swift
//  UUID
//

import PackageDescription

let package = Package(
	name: "UUID",
	products: [
		.library(
			name: "UUID",
			type: .static,
			targets: ["UUID"]),
		.library(
			name: "UUID",
			type: .dynamic,
			targets: ["UUID"])
	],
	dependencies: [
		.package(url: "https://github.com/DavidSkrundz/LibC.git",
		         .upToNextMinor(from: "1.1.0")),
		.package(url: "https://github.com/DavidSkrundz/Hash.git",
		         .upToNextMinor(from: "1.2.0"))
	],
	targets: [
		.target(
			name: "UUID",
			dependencies: ["LibC", "Hash"]),
		.testTarget(
			name: "UUIDTests",
			dependencies: ["UUID"])
	]
)
