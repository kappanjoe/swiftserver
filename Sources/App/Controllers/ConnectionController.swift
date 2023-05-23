//
//  ConnectionController.swift
//  
//
//  Created by Joseph Van Alstyne on 5/18/23.
//

import Fluent
import FluentPostgresDriver
import Vapor

class ConnectionController {
	var clients: WebSocketClients
	
	init(eventLoop: EventLoop) {
		self.clients = WebSocketClients(eventLoop: eventLoop)
	}
	
	func connect(_ ws: WebSocket, db: Database) {
		ws.onBinary { [unowned self] ws, buffer in
			if let msg: WebSocketMessage = buffer.decodeWebsocketMessage(Connect.self) {
				let newClient = WebSocketClient(id: msg.client, socket: ws)
				self.clients.add(newClient)
				try! await User(id: newClient.id).save(on: db)
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
				
				let newMessage = MessageLog(senderID: sender.id)
				try! await newMessage.save(on: db)
				try! await newMessage.$recipients.attach(recipients.map { recipient in
					return User(id: recipient.id)
				}, on: db)
			}
		}
	}
}
