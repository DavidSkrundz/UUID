//
//  UUIDVersion.swift
//  UUID
//

public enum UUIDVersion {
	case v1
	case v3(namespace: Namespace, name: String)
	case v4
	case v5(namespace: Namespace, name: String)
}
