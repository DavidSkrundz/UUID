//
//  UUID.swift
//  UUID
//

import Hash
import LibC

// Reference: https://tools.ietf.org/html/rfc4122
//
//     0                   1                   2                   3
//      0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
//     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//     │                          time_low                             │
//     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//     │       time_mid                │         time_hi_and_version   │
//     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//     │clk_seq_hi_res │  clk_seq_low  │         node (0-1)            │
//     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//     │                         node (2-5)                            │
//     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
//   ┌───┬───┬───┬───┬───┬───┬───┬───┐   ┌───┬───┬───┬───┬───┬───┬───┬───┐
// 0 │ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 1 │ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │
//   └───┴───┴───┴───┴───┴───┴───┴───┘   └───┴───┴───┴───┴───┴───┴───┴───┘
//   ┌───┬───┬───┬───┬───┬───┬───┬───┐   ┌───┬───┬───┬───┬───┬───┬───┬───┐
// 2 │ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 3 │ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │
//   └───┴───┴───┴───┴───┴───┴───┴───┘   └───┴───┴───┴───┴───┴───┴───┴───┘
//   ┌───┬───┬───┬───┬───┬───┬───┬───┐   ┌───┬───┬───┬───┬───┬───┬───┬───┐
// 4 │ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 5 │ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │
//   └───┴───┴───┴───┴───┴───┴───┴───┘   └───┴───┴───┴───┴───┴───┴───┴───┘
//   ┌───┬───┬───┬───┬───┬───┬───┬───┐   ┌───┬───┬───┬───┬───┬───┬───┬───┐
// 6 │ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 7 │ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │
//   └───┴───┴───┴───┴───┴───┴───┴───┘   └───┴───┴───┴───┴───┴───┴───┴───┘
//   ┌───┬───┬───┬───┬───┬───┬───┬───┐   ┌───┬───┬───┬───┬───┬───┬───┬───┐
// 8 │ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 9 │ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │
//   └───┴───┴───┴───┴───┴───┴───┴───┘   └───┴───┴───┴───┴───┴───┴───┴───┘
//   ┌───┬───┬───┬───┬───┬───┬───┬───┐   ┌───┬───┬───┬───┬───┬───┬───┬───┐
// 10│ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 11│ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │
//   └───┴───┴───┴───┴───┴───┴───┴───┘   └───┴───┴───┴───┴───┴───┴───┴───┘
//   ┌───┬───┬───┬───┬───┬───┬───┬───┐   ┌───┬───┬───┬───┬───┬───┬───┬───┐
// 12│ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 13│ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │
//   └───┴───┴───┴───┴───┴───┴───┴───┘   └───┴───┴───┴───┴───┴───┴───┴───┘
//   ┌───┬───┬───┬───┬───┬───┬───┬───┐   ┌───┬───┬───┬───┬───┬───┬───┬───┐
// 14│ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 15│ 0 │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │
//   └───┴───┴───┴───┴───┴───┴───┴───┘   └───┴───┴───┴───┴───┴───┴───┴───┘

public typealias Byte = UInt8

/// A `UUID` which can be used to uniquely identify types, interfaces, and other
/// items.
public struct UUID {
	public static let Nil = UUID(bytes: [Byte](repeating: 0, count: 16))
	
	private static var clockSequence = ClockSequence()
	
	public let bytes: [Byte]
	
	/// Create a new `UUID` from 16 `UInt8`s
	///
	/// - Precondition: `bytes.count == 16`
	public init(bytes: [Byte]) {
		precondition(bytes.count == 16)
		
		self.bytes = bytes
	}
	
	/// Create a new `UUID` from a `String`
	///
	/// - Note: Does not verify that the UUID conforms to a specific version
	///
	/// - Precondition: The `String` is formatted as
	///                 `123e4567-e89b-12d3-a456-426655440000`
	/// - Precondition: Only hex `Character`s are used
	public init(string: String) throws {
		self.bytes = try UUIDStringParser.parseUUIDString(string)
	}
	
	/// Create a new `UUID` of the specified version
	public init(version: UUIDVersion) {
		switch version {
			case .v1:
				let time = Time()
				let interface = Interface.interfaces().first
				let macAddress = interface?.macAddress ?? MACAddress.Nil
				self.bytes = UUID.Version1Bytes(time: time, mac: macAddress)
			case .v3(namespace: _, name: _):
				self.bytes = UUID.Version3Bytes(version)
			case .v4:
				self.bytes = UUID.Version4Bytes()
			case .v5(namespace: _, name: _):
				self.bytes = UUID.Version5Bytes(version)
		}
	}
	
	/// a bits are bottom 32 bits of 100-ns interval
	/// b bits are middle 16 bits of 100-ns interval
	/// c bits are top 12 bits of 100-ns interval
	/// x bits are the clock sequence
	/// y bits are MAC address
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ a │ a │ a │ a │ a │ a │ a │ a ││ a │ a │ a │ a │ a │ a │ a │ a │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ a │ a │ a │ a │ a │ a │ a │ a ││ a │ a │ a │ a │ a │ a │ a │ a │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ b │ b │ b │ b │ b │ b │ b │ b ││ b │ b │ b │ b │ b │ b │ b │ b │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ 0 │ 0 │ 0 │ 1 │ c │ c │ c │ c ││ c │ c │ c │ c │ c │ c │ c │ c │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ 1 │ 0 │ x │ x │ x │ x │ x │ x ││ x │ x │ x │ x │ x │ x │ x │ x │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ y │ y │ y │ y │ y │ y │ y │ y ││ y │ y │ y │ y │ y │ y │ y │ y │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ y │ y │ y │ y │ y │ y │ y │ y ││ y │ y │ y │ y │ y │ y │ y │ y │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ y │ y │ y │ y │ y │ y │ y │ y ││ y │ y │ y │ y │ y │ y │ y │ y │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	private static func Version1Bytes(time: Time, mac: MACAddress) -> [Byte] {
		// Number of 100-ns intervals from 00:00:00.00 15 October 1582
		// to 00:00:00.00 1 January 1970
		let offset: Int64 = 0x01b21dd213814000
		
		let precisionTimeInfo = time.preciseTimeInfo
		let time = precisionTimeInfo.ticksSince1970 + offset
		
		let clockSequence = UUID.clockSequence.clockSequence()
		
		let macBytes = mac.bytes
		
		var bytes = [Byte](repeating: 0, count: 16)
		
		// a
		bytes[0] = UInt8((time >> 24) & 0xFF)
		bytes[1] = UInt8((time >> 16) & 0xFF)
		bytes[2] = UInt8((time >>  8) & 0xFF)
		bytes[3] = UInt8((time >>  0) & 0xFF)
		// b
		bytes[4] = UInt8((time >> 40) & 0xFF)
		bytes[5] = UInt8((time >> 32) & 0xFF)
		// c
		bytes[6] = UInt8((time >> 56) & 0x0F) | 0x10
		bytes[7] = UInt8((time >> 48) & 0xFF)
		// x
		bytes[8] = UInt8(clockSequence[0] & 0x3F) | 0x80
		bytes[9] = UInt8(clockSequence[1] & 0xFF)
		// y
		bytes[10] = macBytes[0]
		bytes[11] = macBytes[1]
		bytes[12] = macBytes[2]
		bytes[13] = macBytes[3]
		bytes[14] = macBytes[4]
		bytes[15] = macBytes[5]
		
		return bytes
	}
	
	/// Unspecified bits are the MD5 of Namespace+Name
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ 0 │ 0 │ 1 │ 1 │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ 1 │ 0 │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	private static func Version3Bytes(_ version: UUIDVersion) -> [Byte] {
		guard case let .v3(namespace, name) = version else { fatalError() }
		
		return self.nameUUIDBytes(namespace: namespace,
								  name: name,
								  hash: MD5.self,
								  versionCode: 0x30)
	}
	
	/// Unspecified bits are random
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ 0 │ 1 │ 0 │ 0 │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ 1 │ 0 │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	private static func Version4Bytes() -> [Byte] {
		var bytes = (1...16).map { _ in UInt8.random() }
		bytes[6] = bytes[6] & 0x0F + 0x40
		bytes[8] = bytes[8] & 0x3F + 0x80
		return bytes
	}
	
	/// Unspecified bits are the SHA1 of Namespace+Name
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ 0 │ 1 │ 0 │ 1 │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │ 1 │ 0 │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	///   ┌───┬───┬───┬───┬───┬───┬───┬───┐┌───┬───┬───┬───┬───┬───┬───┬───┐
	///   │   │   │   │   │   │   │   │   ││   │   │   │   │   │   │   │   │
	///   └───┴───┴───┴───┴───┴───┴───┴───┘└───┴───┴───┴───┴───┴───┴───┴───┘
	private static func Version5Bytes(_ version: UUIDVersion) -> [Byte] {
		guard case let .v5(namespace, name) = version else { fatalError() }
		
		return self.nameUUIDBytes(namespace: namespace,
								  name: name,
								  hash: SHA1.self,
								  versionCode: 0x50)
	}
	
	private static func nameUUIDBytes(namespace: Namespace,
									  name: String,
									  hash: Hashing.Type,
									  versionCode: Byte) -> [Byte] {
		let fullName = namespace.uuid.bytes + name.utf8.map { Byte($0) }
		var bytes = hash.hash(fullName).bytes
		
		bytes[6] = bytes[6] & 0x0F + versionCode
		bytes[8] = bytes[8] & 0x3F + 0x80
		
		return bytes
	}
}
