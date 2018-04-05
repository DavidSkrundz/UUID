//
//  UUIDStringParser.swift
//  UUID
//

enum UUIDParserError: Error {
	case MalformedUUIDString
}

internal struct UUIDStringParser {
	private init() {}
	
	/// Convert two hex `Character`s into a `Byte`
	///
	/// - Precondition: The `Character`s are `[0-9a-fA-F]`
	///
	/// - Returns: The `Byte` that is represented by the `Character`s
	static func parseByte(_ char1: Character, _ char2: Character) -> Byte {
		precondition(char1.isHexDigit)
		precondition(char2.isHexDigit)
		
		guard let byte = Byte("\(char1)\(char2)", radix: 16) else {
			fatalError("Precondition failure - Non-hex Character found")
		}
		return byte
	}
	
	/// Parses a hex `String` two `Character`s at a time
	///
	/// - Precondition: The `Character`s are `[0-9a-fA-F]`
	/// - Precondition: The length of `characters` is a multiple of 2
	///
	/// - Returns: The `Byte` values of the `Character`s
	static func parseBytes(_ characters: [Character]) -> [Byte] {
		precondition(characters.count % 2 == 0)
		
		var characters = characters
		var bytes = [Byte]()
		while characters.count > 0 {
			let char1 = characters.removeFirst()
			let char2 = characters.removeFirst()
			bytes.append(UUIDStringParser.parseByte(char1, char2))
		}
		return bytes
	}
	
	/// Parse a UUID `String` that has `-` separated groups
	///
	/// - Throws: `UUIDParserError` if the `String` is not formatted properly
	///
	/// - Returns: The `Byte`s that are represented by the `String`
	static func parseUUIDString(_ string: String) throws -> [Byte] {
		if string.count != 36 { throw UUIDParserError.MalformedUUIDString }
		let characters: [Character] = string.filter { $0 != "-" }
		if characters.count != 32 { throw UUIDParserError.MalformedUUIDString }
		let hex = characters.filter { $0.isHexDigit }
		if hex.count != 32 { throw UUIDParserError.MalformedUUIDString }
		return self.parseBytes(hex)
	}
}
