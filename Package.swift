//
//  Package.swift
//  UUID
//

import PackageDescription

let package = Package(
	name: "UUID",
	dependencies: [
		.Package(url: "https://github.com/DavidSkrundz/Hash.git", majorVersion: 1, minor: 0),
		.Package(url: "https://github.com/DavidSkrundz/LibC.git", majorVersion: 1, minor: 0),
		.Package(url: "https://github.com/DavidSkrundz/Regex.git", majorVersion: 0, minor: 1),
		.Package(url: "https://github.com/DavidSkrundz/Util.git", majorVersion: 1, minor: 0),
	]
)

let staticLibrary = Product(
	name: "UUID",
	type: .Library(.Static),
	modules: ["UUID"]
)
let dynamicLibrary = Product(
	name: "UUID",
	type: .Library(.Dynamic),
	modules: ["UUID"]
)

products.append(staticLibrary)
products.append(dynamicLibrary)
