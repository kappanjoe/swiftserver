//
//  ConnectionSystem.swift
//  
//
//  Created by Joseph Van Alstyne on 5/18/23.
//

import Vapor

class ConnectionSystem {
	var clients: WebSocketClients
	
	init(eventLoop: EventLoop) {
		self.clients = WebSocketClients(eventLoop: eventLoop)
	}
	
	func connect(_ ws: WebSocket) {
		ws.onBinary { [unowned self] ws, buffer in
			if let msg = buffer.decodeWebsocketMessage(Connect.self) {
				let newClient = WebSocketClient(id: msg.client, socket: ws)
				self.clients.add(newClient)
			}
		}
	}
}
