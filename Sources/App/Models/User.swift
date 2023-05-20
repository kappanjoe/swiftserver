//
//  User.swift
//  
//
//  Created by Joseph Van Alstyne on 5/20/23.
//

import Fluent
import FluentPostgresDriver
import Vapor

final class User: Model {
	static let schema = "users"
	
	@ID(key: .id)
	var id: UUID?
	
	@Timestamp(key: "created_at", on: .create)
	var createdAt: Date?
	
	@Children(for: \.$sender)
	var sentMessages: [MessageLog]
	
	@Siblings(through: MessageRecipient.self, from: \.$recipient, to: \.$message)
	public var receivedMessages: [MessageLog]
	
	init() { }
	
	init(id: UUID? = nil, createdAt: Date? = nil) {
		self.id = id
		self.createdAt = createdAt
	}
}
