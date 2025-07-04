import Combine
import FirebaseCore

class MessageRemoteDataSource {
    private let tag = String(describing: MessageRemoteDataSource.self)
    private let messageApi: MessageApi
    
    init(messageApi: MessageApi) {
        self.messageApi = messageApi
    }
    
    func listenMessages(conversation: Conversation, offsetTime: Date?) -> AnyPublisher<[Message], Error> {
        let offsetTime: Timestamp? = offsetTime.map { Timestamp(date: $0) }
        return messageApi.listenMessages(conversation: conversation, offsetTime: offsetTime)
            .map { remoteMessges in
                remoteMessges.map { $0.toMessage() }
            }
            .eraseToAnyPublisher()
    }
    
    func createMessage(message: Message) async throws {
        try await mapFirebaseException(
            block: {
                let data = message.toRemote().toMap()
                try await messageApi.createMessage(
                    conversationId: message.conversationId,
                    messageId: message.id.toString(),
                    data: data
                )
            },
            tag: tag,
            message: "Failed to create message"
        )
    }
    
    func updateSeenMessage(message: Message) async throws {
        try await messageApi.updateSeenMessage(remoteMessage: message.toRemote())
    }
    
    func stopListeningMessages() {
        messageApi.stopListeningMessages()
    }
}
