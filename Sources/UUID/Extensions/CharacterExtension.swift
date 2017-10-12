//
//  CharacterExtension.swift
//  UUID
//

extension Character {
	/// - Returns: `true` iff `self` is a digit from `0` to `9` or `a` to `f` or
	///            `A` to `F`
	internal var isHexDigit: Bool {
		return
			(self >= "0" && self <= "9") ||
			(self >= "A" && self <= "F") ||
			(self >= "a" && self <= "f")
	}
}
