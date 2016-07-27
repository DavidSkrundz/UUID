//
//  UUID+StringConvertible.swift
//  UUID
//

import ProtocolNumbers

private let indexToCharacterMap: [Character] = [
	"0", "1", "2", "3", "4",
	"5", "6", "7", "8", "9",
	"a", "b", "c", "d", "e",
	"f"
]

extension UUID: CustomStringConvertible {
	public var description: String {
		var characters = self.bytes
			.flatMap { [$0 ≫ 4, $0 & 0x0F] }
			.map { indexToCharacterMap[Int($0)] }
		
		characters.insert("-", at: 8)
		characters.insert("-", at: 13)
		characters.insert("-", at: 18)
		characters.insert("-", at: 23)
		
		return characters
			.reduce("") { $0 + "\($1)" }
	}
}
