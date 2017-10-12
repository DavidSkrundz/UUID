//
//  LinuxMain.swift
//  UUID
//

import XCTest
@testable import UUIDTests

XCTMain([
	testCase(UUIDStringParserTests.allTests),
	testCase(UUIDTests.allTests),
])
