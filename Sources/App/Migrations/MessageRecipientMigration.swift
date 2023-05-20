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
		// Prepare
	}

	func revert(on database: FluentKit.Database) async throws {
		// Revert
	}
}
