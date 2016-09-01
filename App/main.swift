import HTTP
import Vapor
import TLS

let config = try Vapor.Config(prioritized: [.directory(root: workingDirectory + "Config/")])
guard let token = config["bot-config", "token"]?.string else { throw BotError.missingConfig }

let rtmResponse = try BasicClient.loadRealtimeApi(token: token)
guard let webSocketURL = rtmResponse.data["url"]?.string else { throw BotError.invalidResponse }

try WebSocket.connect(to: webSocketURL) { ws in
    print("Connected to \(webSocketURL)")

    ws.onText = { ws, text in

        let event = try JSON(bytes: text.utf8.array)
        guard
            let channel = event["channel"]?.string,
            let text = event["text"]?.string
            else { return }

        if text.contains("すし") {
            let response = SlackMessage(to: channel, text: "🍣")
            try ws.send(response)
        }
    }

    ws.onClose = { ws, _, _, _ in
        print("\n[CLOSED]\n")
    }
}
