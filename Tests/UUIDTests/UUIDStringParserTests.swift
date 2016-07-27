//
//  UUIDStringParserTests.swift
//  UUID
//

@testable import UUID
import XCTest

class UUIDStringParserTests: XCTestCase {
	func testSingleByte() {
		let byte = UUIDStringParser.parseByte("0", "1")
		XCTAssertEqual(byte, 0x01)
	}
	
	func testLetterByte() {
		let byte = UUIDStringParser.parseByte("A", "F")
		XCTAssertEqual(byte, 0xAF)
	}
	
	func testMultibyte() {
		let bytes = UUIDStringParser.parseBytes(["0", "1", "a", "f"])
		XCTAssertEqual(bytes, [0x01, 0xAF])
	}
	
	func testUUIDString() {
		let bytes = try! UUIDStringParser.parseUUIDString("123e4567-e89b-12d3-a456-426655440000")
		XCTAssertEqual(bytes, [
			0x12, 0x3E, 0x45, 0x67,
			0xE8, 0x9B,
			0x12, 0xD3,
			0xA4, 0x56,
			0x42, 0x66, 0x55, 0x44, 0x00, 0x00,
		])
	}
	
	static var allTests = [
		("testSingleByte", testSingleByte),
		("testLetterByte", testLetterByte),
		("testMultibyte", testMultibyte),
		("testUUIDString", testUUIDString),
	]
}
