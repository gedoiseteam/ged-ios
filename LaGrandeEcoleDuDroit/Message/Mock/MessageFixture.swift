import Foundation

private let calendar = Calendar.current
private let currentDate = Date()

let messageFixture = Message(
    id: 1,
    senderId: userFixture.id,
    recipientId: userFixture2.id,
    conversationId: "1",
    content: "Hi, how are you ?",
    date: Date(),
    seen: true,
    state: .sent
)

let messageFixture2 = Message(
    id: 1,
    senderId: userFixture.id,
    recipientId: userFixture2.id,
    conversationId: "1",
    content: "Bonjour, j'espère que vous allez bien. " +
            "Je voulais prendre un moment pour vous parler de quelque chose d'important. " +
            "En fait, je pense qu'il est essentiel que nous discutions de la direction que prend notre projet, " +
            "car il y a plusieurs points que nous devrions clarifier.",
    date: Date(),
    seen: true,
    state: .sent
)

let messagesFixture = [
    Message(
        id: 2,
        senderId: userFixture.id,
        recipientId: userFixture2.id,
        conversationId: "1",
        content: "Hi, how are you ?",
        date: calendar.date(byAdding: .minute, value: -10, to: currentDate) ?? currentDate,
        seen: true,
        state: .error
    ),
    Message(
        id: 3,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Fine, and you ?",
        date: calendar.date(byAdding: .minute, value: -5, to: currentDate) ?? currentDate,
        seen: true,
        state: .sent
    ),
    Message(
        id: 4,
        senderId: userFixture.id,
        recipientId: userFixture2.id,
        conversationId: "1",
        content: "Fine, thanks !",
        date: calendar.date(byAdding: .minute, value: -2, to: currentDate) ?? currentDate,
        seen: true,
        state: .sent
    ),
    Message(
        id: 5,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Great !",
        date: calendar.date(byAdding: .minute, value: -1, to: currentDate) ?? currentDate,
        seen: true,
        state: .sent
    ),
    Message(
        id: 6,
        senderId: userFixture.id,
        recipientId: userFixture2.id,
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        seen: false,
        state: .sent
    ),
    Message(
        id: 7,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        seen: false,
        state: .sent
    ),
    Message(
        id: 8,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        seen: false,
        state: .sent
    ),
    Message(
        id: 9,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        seen: false,
        state: .sent
    ),
    Message(
        id: 10,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        seen: false,
        state: .sent
    ),
    Message(
        id: 11,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        seen: false,
        state: .sent
    ),
    Message(
        id: 12,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        seen: false,
        state: .sent
    ),
    Message(
        id: 13,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        seen: false,
        state: .sent
    ),
    Message(
        id: 14,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        seen: false,
        state: .sent
    ),
    Message(
        id: 15,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        seen: false,
        state: .sent
    ),
    Message(
        id: 16,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        seen: false,
        state: .sent
    ),
    Message(
        id: 17,
        senderId: userFixture.id,
        recipientId: userFixture2.id,
        conversationId: "1",
        content: "Hi, how are you ?",
        date: calendar.date(byAdding: .minute, value: -10, to: currentDate) ?? currentDate,
        seen: true,
        state: .sent
    ),
    Message(
        id: 18,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Fine, and you ?",
        date: calendar.date(byAdding: .minute, value: -5, to: currentDate) ?? currentDate,
        seen: true,
        state: .sent
    ),
    Message(
        id: 19,
        senderId: userFixture.id,
        recipientId: userFixture2.id,
        conversationId: "1",
        content: "Fine, thanks !",
        date: calendar.date(byAdding: .minute, value: -2, to: currentDate) ?? currentDate,
        seen: true,
        state: .sent
    ),
    Message(
        id: 20,
        senderId: userFixture2.id,
        recipientId: userFixture.id,
        conversationId: "1",
        content: "Great !",
        date: calendar.date(byAdding: .minute, value: -1, to: currentDate) ?? currentDate,
        seen: true,
        state: .sent
    ),
    Message(
        id: 21,
        senderId: userFixture.id,
        recipientId: userFixture2.id,
        conversationId: "1",
        content: "Ok, see you later !",
        date: currentDate,
        seen: false,
        state: .sent
    ),
]


let lastMessagesFixture = [
    Message(
        id: 1,
        senderId: userFixture.id,
        recipientId: userFixture2.id,
        conversationId: "1",
        content: "Last message conversation 1",
        date: calendar.date(byAdding: .minute, value: -10, to: currentDate) ?? currentDate,
        seen: true,
        state: .sent
    ),
    Message(
        id: 1,
        senderId: userFixture.id,
        recipientId: userFixture2.id,
        conversationId: "2",
        content: "Last message conversation 2",
        date: calendar.date(byAdding: .minute, value: -5, to: currentDate) ?? currentDate,
        seen: true,
        state: .sent
    ),
    Message(
        id: 1,
        senderId: userFixture.id,
        recipientId: userFixture2.id,
        conversationId: "3",
        content: "Last message conversation 3",
        date: calendar.date(byAdding: .minute, value: -2, to: currentDate) ?? currentDate,
        seen: true,
        state: .sent
    ),
    Message(
        id: 1,
        senderId: userFixture.id,
        recipientId: userFixture2.id,
        conversationId: "4",
        content: "Last message conversation 4",
        date: calendar.date(byAdding: .minute, value: -1, to: currentDate) ?? currentDate,
        seen: true,
        state: .sent
    ),
    Message(
        id: 1,
        senderId: userFixture.id,
        recipientId: userFixture2.id,
        conversationId: "5",
        content: "Last message conversation 5",
        date: currentDate,
        seen: false,
        state: .sent
    )
]
