//
//  Package.swift
//  UUID
//

import PackageDescription

let package = Package(
	name: "UUID",
	dependencies: [
		.Package(url: "https://github.com/DavidSkrundz/Hash.git", versions: Version(1,0,0)..<Version(1,1,0)),
		.Package(url: "https://github.com/DavidSkrundz/LibC.git", versions: Version(1,0,0)..<Version(1,1,0)),
		.Package(url: "https://github.com/DavidSkrundz/Regex.git", versions: Version(0,1,0)..<Version(0,2,0)),
		.Package(url: "https://github.com/DavidSkrundz/Util.git", versions: Version(1,0,0)..<Version(1,1,0)),
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
