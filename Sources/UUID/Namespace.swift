//
//  Namespace.swift
//  UUID
//

public enum Namespace {
	case DN
	case DNS
	case URL
	case OID
	case Name
	
	internal var uuid: UUID {
		var bytes: [Byte] = [
			0x6B, 0xA7, 0xB8, 0x00,
			0x9D, 0xAD,
			0x11, 0xD1,
			0x80, 0xB4, 0x00, 0xC0, 0x4F, 0xD4, 0x30, 0xC8
		]
		switch self {
			case .DN(_):   bytes[3] = 0x14
			case .DNS(_):  bytes[3] = 0x10
			case .URL(_):  bytes[3] = 0x11
			case .OID(_):  bytes[3] = 0x12
			case .Name(_): bytes[3] = 0x13
		}
		return UUID(bytes: bytes)
	}
}
