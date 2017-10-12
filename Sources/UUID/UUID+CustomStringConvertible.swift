//
//  UUID+CustomStringConvertible.swift
//  UUID
//

extension UUID: CustomStringConvertible {
	public var description: String {
		var characters = Array(self.bytes.hexString)
		characters.insert("-", at: 8)
		characters.insert("-", at: 13)
		characters.insert("-", at: 18)
		characters.insert("-", at: 23)
		return String(characters)
	}
}
