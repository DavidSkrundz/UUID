//
//  ByteArrayExtension.swift
//  UUID
//

import ProtocolNumbers

extension Collection where Iterator.Element == Byte,
                           SubSequence.Iterator.Element == Byte,
                           IndexDistance == Int {
	/// Performs an XOR operation of the two halves of the `Array`
	///
	/// - Returns: A `[Byte]` that is half as long as the original
	internal func xorHalves() -> [Byte] {
		let halfLength = self.count / 2
		let firstHalf = self.prefix(halfLength)
		let lastHalf = self.suffix(halfLength)
		return zip(firstHalf, lastHalf).map { $0 ^ $1 }
	}
	
	/// Converts a `[Byte]` to an `Int`
	///
	/// - Precondition: `bytes.count == sizeof(Int.self)`
	internal func combineToInt() -> Int {
		precondition(self.count == MemoryLayout<Int>.size)
		
		return self.reduce(0) { ($0 ≪ 8) + Int($1) }
	}
}
