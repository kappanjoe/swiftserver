//
//  UniqueMessageRecipientMigration.swift
//  
//
//  Created by Joseph Van Alstyne on 5/23/23.
//

import Fluent
import FluentPostgresDriver
import Vapor

struct UniqueMessageRecipientMigration: AsyncMigration {
	func prepare(on database: FluentKit.Database) async throws {
		try await database.schema("message+recipient")
			.unique(on: "message_id", "recipient_user_id")
			.update()
	}

	func revert(on database: FluentKit.Database) async throws {
		try await database.schema("message+recipient")
			.deleteUnique(on: "message_id", "recipient_user_id" )
			.update()
	}
}
