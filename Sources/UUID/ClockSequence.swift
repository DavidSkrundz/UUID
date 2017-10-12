//
//  ClockSequence.swift
//  UUID
//

import LibC

/// Stores the ClockSequence bytes with the cabability of changing them
/// if the system time was moved backwards
internal struct ClockSequence {
	private var lastGenTime: Int64 = 0
	private var clockSequenceBytes: [Byte] = ClockSequence.newBytes()
	
	internal mutating func clockSequence() -> [Byte] {
		let time = Time().preciseTimeInfo.ticksSince1970
		if time <= self.lastGenTime {
			self.clockSequenceBytes = ClockSequence.newBytes()
		}
		lastGenTime = time
		return self.clockSequenceBytes
	}
	
	private static func newBytes() -> [Byte] {
		return [UInt8.random(), UInt8.random()]
	}
}
