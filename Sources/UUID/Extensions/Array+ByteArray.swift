//
//  Array+ByteArray.swift
//  UUID
//

private let indexToHexMap: [Character] = [
	"0", "1", "2", "3", "4", "5", "6", "7",
	"8", "9", "a", "b", "c", "d", "e", "f"
]

extension Array where Element == Byte {
	internal var hexString: String {
		let halfbytes = self.flatMap { [$0 >> 4, $0 & 0x0F] }
		let characters = halfbytes.map { indexToHexMap[Int($0)] }
		return characters.reduce("") { $0 + "\($1)" }
	}
	
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
	/// - Note: The size of `Int` can equal to `Int32` or `Int64` depending on
	///         the platform
	///
	/// - Precondition: `bytes.count == sizeof(Int.self)`
	internal func combineToInt() -> Int {
		precondition(self.count == MemoryLayout<Int>.size)
		
		return self.reduce(0) { ($0 << 8) + Int($1) }
	}
}
