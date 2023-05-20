//
//  WebSocket.swift
//  
//
//  Created by Joseph Van Alstyne on 5/17/23.
//

import Vapor

open class WebSocketClient {
	open var id: UUID
	open var socket: WebSocket
	
	public init(id: UUID, socket: WebSocket) {
		self.id = id
		self.socket = socket
	}
}
