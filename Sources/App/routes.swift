import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req -> EventLoopFuture<View> in
		return req.view.render("hello", ["name": "Leaf"])
    }
	
	app.get("hello", ":name") { req async throws -> View in
		let name = req.parameters.get("name")!
		return try await req.view.render("hello", ["name": name])
	}
}
