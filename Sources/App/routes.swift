import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
	
	app.get("hello", ":name") { req -> String in
		let name = req.parameters.get("name")!
		return "Hello, \(name)!"
	}
	
	app.webSocket("yo") { req, ws in
		// Connected WebSocket
		
		ws.onText { ws, text in
			switch text {
			case "yo":
				ws.send("hey")
			default:
				return
			}
		}
		
	}
}
