const uuidv4 = () => {
    return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, c => (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16));
};
const uuid = uuidv4();

WebSocket.prototype.sendData = function(data) {
	const string = JSON.stringify({ client: uuid, data: data });
	const blob = new Blob([string], { type: "application/json" });
	this.send(blob);
};

const decodeBlob = (blob) => {
	return new Promise((resolve, reject) => {
		let fr = new FileReader();
		fr.onload = () => {
			resolve(JSON.parse(fr.result));
		};
		fr.readAsText(blob);
	});
};

let ws = undefined;
const openWebSocket = () => {
	ws = new WebSocket("ws://" + window.location.host + "/channel");
	ws.onopen = () => {
		console.log("Socket opened.");
		ws.sendData({ connect: true });
	};
	
	ws.onmessage = (event) => {
		decodeBlob(event.data).then((json) => {
			console.log("Message received: ", json);
		});
	};
	
	ws.onclose = () => {
		console.log("Socket closed.");
	};
	
	let yoButton = document.createElement("button");
	yoButton.innerText = "Yo";
	yoButton.onclick = () => {
		ws.sendData({ message: "Yo" });
	};
	
	window.onload = () => {
		document.body.appendChild(yoButton);
	};
};

const closeWebSocket = () => {
	if ( ws !== undefined ) {
        ws.close();
    }
};

openWebSocket();
