//
//  ConnectionController.swift
//  
//
//  Created by Joseph Van Alstyne on 5/18/23.
//

import Vapor

class ConnectionController {
	var clients: WebSocketClients
	
	init(eventLoop: EventLoop) {
		self.clients = WebSocketClients(eventLoop: eventLoop)
	}
	
	func connect(_ ws: WebSocket) {
		ws.onBinary { [unowned self] ws, buffer in
			if let msg: WebSocketMessage = buffer.decodeWebsocketMessage(Connect.self) {
				let newClient = WebSocketClient(id: msg.client, socket: ws)
				self.clients.add(newClient)
			}
			
			if
				let msg: WebSocketMessage = buffer.decodeWebsocketMessage(Yo.self),
				let sender: WebSocketClient = self.clients.find(msg.client)
			{
				let recipients = self.clients.active.filter { $0.id != sender.id }
				let yoData = try! JSONEncoder().encode(Yo(message: "Yo"))
				
				recipients.forEach { recipient in
					recipient.socket.send([UInt8](yoData))
				}
			}
		}
	}
}
