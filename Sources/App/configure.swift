import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
	
	let connectionSystem = ConnectionSystem(eventLoop: app.eventLoopGroup.next())
	
	app.webSocket("channel") { req, ws in
		connectionSystem.connect(ws)
	}
	
    // register routes
    try routes(app)
}
