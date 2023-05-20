//
//  MessageRecipientMigration.swift
//  
//
//  Created by Joseph Van Alstyne on 5/20/23.
//

import Fluent
import FluentPostgresDriver
import Vapor

struct MessageRecipientMigration: AsyncMigration {
	func prepare(on database: FluentKit.Database) async throws {
		try await database.schema("message+recipient")
			.id()
			.field("message_id", .uuid, .required, .references("message_logs", "id"))
			.field("recipient_user_id", .uuid, .required, .references("users", "id"))
			.create()
	}

	func revert(on database: FluentKit.Database) async throws {
		try await database.schema("message+recipient").delete()
	}
}
