//
//  UUID+Equatable.swift
//  UUID
//

extension UUID: Equatable {}
public func ==(lhs: UUID, rhs: UUID) -> Bool {
	return lhs.bytes == rhs.bytes
}
