//
//  ClockSequence.swift
//  UUID
//

import LibC
import UnicodeOperators

/// Stores the ClockSequence bytes with the cabability of changing them
/// if the system time was moved backwards
internal struct ClockSequence {
	private var lastGenTime: Int64 = 0
	private var clockSequenceBytes: [Byte] = ClockSequence.NewBytes()
	
	internal mutating func clockSequence() -> [Byte] {
		let time = Time().preciseTimeInfo.ticksSince1970
		if time ≤ self.lastGenTime {
			self.clockSequenceBytes = ClockSequence.NewBytes()
		}
		lastGenTime = time
		return self.clockSequenceBytes
	}
	
	private static func NewBytes() -> [Byte] {
		return [Random.UInt8(), Random.UInt8()]
	}
}
