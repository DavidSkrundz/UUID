//
//  LinuxMain.swift
//  UUID
//

@testable import UUIDTests
import XCTest

XCTMain([
	testCase(UUIDStringParserTests.allTests),
	testCase(UUIDTests.allTests),
])
