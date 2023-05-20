//
//  MessageRecipient.swift
//  
//
//  Created by Joseph Van Alstyne on 5/20/23.
//

import Fluent
import FluentPostgresDriver
import Vapor

final class MessageRecipient: Model {
	static let schema = "message+recipient"
	
	@ID(key: .id)
	var id: UUID?
	
	@Parent(key: "message_id")
	var message: MessageLog
	
	@Parent(key: "recipient_user_id")
	var recipient: User
	
	init() { }
	
	init(id: UUID? = nil, message: MessageLog, recipient: User) {
		self.id = id
		self.$message.id = try! message.requireID()
		self.$recipient.id = try! recipient.requireID()
	}
}
