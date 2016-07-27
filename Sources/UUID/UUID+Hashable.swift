//
//  UUID+Hashable.swift
//  UUID
//

extension UUID: Hashable {
	public var hashValue: Int {
		if MemoryLayout<Int>.size == MemoryLayout<Int32>.size {
			return self.bytes
				.xorHalves()
				.xorHalves()
				.combineToInt()
		} else {
			return self.bytes
				.xorHalves()
				.combineToInt()
		}
	}
}
