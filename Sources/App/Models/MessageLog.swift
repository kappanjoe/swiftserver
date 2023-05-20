//
//  MessageLog.swift
//  
//
//  Created by Joseph Van Alstyne on 5/20/23.
//

import Fluent
import FluentPostgresDriver
import Vapor

final class MessageLog: Model {
	static let schema = "message_logs"
	
	@ID(key: .id)
	var id: UUID?
	
	@Timestamp(key: "sent_at", on: .create)
	var sentAt: Date?

	@Parent(key: "sender_user_id")
	var sender: User
	
	@Siblings(through: MessageRecipient.self, from: \.$message, to: \.$recipient)
	public var recipients: [User]
	
	init() { }
	
	init(id: UUID? = nil, senderID: User.IDValue, recipients: String, sentAt: Date? = nil) {
		self.id = id
		self.sentAt = sentAt
		self.$sender.id = senderID
	}
}
