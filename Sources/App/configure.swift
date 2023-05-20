import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

public func configure(_ app: Application) async throws {
	try app.databases.use(.postgres(url: "<connection string>"), as: .psql)
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
	app.views.use(.leaf)
	
	let connectionController = ConnectionController(eventLoop: app.eventLoopGroup.next())
	
	app.webSocket("channel") { req, ws in
		connectionController.connect(ws)
	}
	
    try routes(app)
}
