import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
	app.views.use(.leaf)
	
	let connectionController = ConnectionController(eventLoop: app.eventLoopGroup.next())
	
	app.webSocket("channel") { req, ws in
		connectionController.connect(ws)
	}
	
    // register routes
    try routes(app)
}
