//
//  WebsocketMessage.swift
//  
//
//  Created by Joseph Van Alstyne on 5/17/23.
//

import Vapor

struct WebSocketMessage<T: Codable>: Codable {
	let client: UUID
	let data: T
}

extension ByteBuffer {
	func decodeWebsocketMessage<T: Codable>(_ type: T.Type) -> WebSocketMessage<T>? {
		try? JSONDecoder().decode(WebSocketMessage<T>.self, from: self)
	}
}

struct Connect: Codable {
	let connect: Bool
}

struct Yo: Codable {
	let message: String
}
