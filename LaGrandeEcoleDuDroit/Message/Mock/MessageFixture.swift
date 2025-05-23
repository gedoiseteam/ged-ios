import Foundation

private let calendar = Calendar.current
private let currentDate = Date.now

let messageFixture = Message(
    id: "1",
    conversationId: "1",
    content: "Hi, how are you ?",
    date: Date.now,
    isRead: true,
    senderId: userFixture.id,
    type: MessageType.text,
    state: .sent
)

let messagesFixture = [
    Message(
        id: "2",
        conversationId: "1",
        content: "Hi, how are you ?",
        date: calendar.date(byAdding: .minute, value: -10, to: currentDate) ?? currentDate,
        isRead: true,
        senderId: userFixture.id,
        type: MessageType.text,
        state: .sent
    ),
    Message(
        id: "3",
        conversationId: "1",
        content: "Fine, and you ?",
        date: calendar.date(byAdding: .minute, value: -5, to: currentDate) ?? currentDate,
        isRead: true,
        senderId: userFixture2.id,
        type: MessageType.text,
        state: .sent
    ),
    Message(
        id: "4",
        conversationId: "1",
        content: "Fine, thanks !",
        date: calendar.date(byAdding: .minute, value: -2, to: currentDate) ?? currentDate,
        isRead: true,
        senderId: userFixture.id,
        type: MessageType.text,
        state: .sent
    ),
    Message(
        id: "5",
        conversationId: "1",
        content: "Great !",
        date: calendar.date(byAdding: .minute, value: -1, to: currentDate) ?? currentDate,
        isRead: true,
        senderId: userFixture2.id,
        type: MessageType.text,
        state: .sent
    ),
    Message(
        id: "6",
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        isRead: false,
        senderId: userFixture.id,
        type: MessageType.text,
        state: .sent
    ),
    Message(
        id: "7",
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        isRead: false,
        senderId: userFixture2.id,
        type: MessageType.text,
        state: .sent
    ),
    Message(
        id: "8",
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        isRead: false,
        senderId: userFixture2.id,
        type: MessageType.text,
        state: .sent
    ),
    Message(
        id: "9",
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        isRead: false,
        senderId: userFixture2.id,
        type: MessageType.text,
        state: .sent
    )
]


let lastMessagesFixture = [
    Message(
        id: "1",
        conversationId: "1",
        content: "Last message conversation 1",
        date: calendar.date(byAdding: .minute, value: -10, to: currentDate) ?? currentDate,
        isRead: true,
        senderId: userFixture.id,
        type: MessageType.text,
        state: .sent
    ),
    Message(
        id: "1",
        conversationId: "2",
        content: "Last message conversation 2",
        date: calendar.date(byAdding: .minute, value: -5, to: currentDate) ?? currentDate,
        isRead: true,
        senderId: userFixture.id,
        type: MessageType.text,
        state: .sent
    ),
    Message(
        id: "1",
        conversationId: "3",
        content: "Last message conversation 3",
        date: calendar.date(byAdding: .minute, value: -2, to: currentDate) ?? currentDate,
        isRead: true,
        senderId: userFixture.id,
        type: MessageType.text,
        state: .sent
    ),
    Message(
        id: "1",
        conversationId: "4",
        content: "Last message conversation 4",
        date: calendar.date(byAdding: .minute, value: -1, to: currentDate) ?? currentDate,
        isRead: true,
        senderId: userFixture.id,
        type: MessageType.text,
        state: .sent
    ),
    Message(
        id: "1",
        conversationId: "5",
        content: "Last message conversation 5",
        date: currentDate,
        isRead: false,
        senderId: userFixture.id,
        type: MessageType.text,
        state: .sent
    )
]
