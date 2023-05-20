//
//  MessageLogMigration.swift
//  
//
//  Created by Joseph Van Alstyne on 5/20/23.
//

import Fluent
import FluentPostgresDriver
import Vapor

struct MessageLogMigration: AsyncMigration {	
	func prepare(on database: FluentKit.Database) async throws {
		try await database.schema("message_logs")
			.id()
			.field("sent_at", .datetime, .required)
			.field("sender_user_id", .uuid, .required, .references("users", "id"))
			.create()
	}

	func revert(on database: FluentKit.Database) async throws {
		try await database.schema("message_logs").delete()
	}
}
