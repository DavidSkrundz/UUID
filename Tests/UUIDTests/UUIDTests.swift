//
//  UUIDTests.swift
//  UUID
//

@testable import UUID
import XCTest

class UUIDTests: XCTestCase {
	func testVersion1() {
		let uuid = UUID(version: .v1)
		XCTAssertEqual(uuid.bytes[6] & 0xF0, 0x10)
		XCTAssertEqual(uuid.bytes[8] & 0xC0, 0x80)
	}
	
	func testVersion3() {
		let version = UUIDVersion.v3(namespace: Namespace.Name, name: "12345")
		let uuid = UUID(version: version)
		XCTAssertEqual(uuid.bytes[6] & 0xF0, 0x30)
		XCTAssertEqual(uuid.bytes[8] & 0xC0, 0x80)
	}
	
	func testRandomUUIDIsVersion4() {
		for _ in 0..<100 {
			let uuid = UUID(version: .v4)
			XCTAssertEqual(uuid.bytes[6] & 0xF0, 0x40)
			XCTAssertEqual(uuid.bytes[8] & 0xC0, 0x80)
		}
	}
	
	func testVersion5() {
		let version = UUIDVersion.v5(namespace: Namespace.Name, name: "12345")
		let uuid = UUID(version: version)
		XCTAssertEqual(uuid.bytes[6] & 0xF0, 0x50)
		XCTAssertEqual(uuid.bytes[8] & 0xC0, 0x80)
	}
	
	func testStringConversion() {
		let uuid = UUID(bytes: [
			0x12, 0x3E, 0x45, 0x67,
			0xE8, 0x9B,
			0x12, 0xD3,
			0xA4, 0x56,
			0x42, 0x66, 0x55, 0x44, 0x00, 0x00,
		])
		XCTAssertEqual("\(uuid)", "123e4567-e89b-12d3-a456-426655440000")
	}
	
	func testHash() {
		let uuid1 = UUID(version: .v4)
		let uuid2 = UUID(version: .v4)
		XCTAssertEqual(uuid1.hashValue, uuid1.hashValue)
		XCTAssertNotEqual(uuid1.hashValue, uuid2.hashValue)
	}
	
	static var allTests = [
		("testVersion1", testVersion1),
		("testVersion3", testVersion3),
		("testRandomUUIDIsVersion4", testRandomUUIDIsVersion4),
		("testVersion5", testVersion5),
		("testStringConversion", testStringConversion),
		("testHash", testHash),
	]
}
