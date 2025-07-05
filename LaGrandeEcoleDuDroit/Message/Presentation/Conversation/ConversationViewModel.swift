import Foundation
import Combine

class ConversationViewModel: ObservableObject {
    private let userRepository: UserRepository
    private let deleteConversationUseCase: DeleteConversationUseCase
    private let getConversationsUiUseCase: GetConversationsUiUseCase
    private var cancellables: Set<AnyCancellable> = []
    private var defaultConversations: [ConversationUi] = []
    private let tag = String(describing: ConversationViewModel.self)
    
    @Published var uiState: ConversationUiState = ConversationUiState()
    @Published var event: SingleUiEvent? = nil
    
    init(
        userRepository: UserRepository,
        getConversationsUiUseCase: GetConversationsUiUseCase,
        deleteConversationUseCase: DeleteConversationUseCase
    ) {
        self.userRepository = userRepository
        self.getConversationsUiUseCase = getConversationsUiUseCase
        self.deleteConversationUseCase = deleteConversationUseCase
        listenConversations()
    }
    
    func deleteConversation(conversation: Conversation) {
        do {
            guard let user = userRepository.currentUser else {
                throw UserError.currentUserNotFound
            }
            deleteConversationUseCase.execute(conversation: conversation, userId: user.id)
        } catch {
            event = ErrorEvent(message: mapErrorMessage(error))
        }
    }
    
    private func listenConversations() {
        getConversationsUiUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] conversations in
                let sortedConversations = conversations.sorted {
                    $0.lastMessage.date > $1.lastMessage.date
                }
                self?.uiState.conversations = sortedConversations
                self?.defaultConversations = sortedConversations
            }.store(in: &cancellables)
    }
    
    private func mapErrorMessage(_ error: Error) -> String {
        mapNetworkErrorMessage(error) {
            if error as? UserError == .currentUserNotFound {
                getString(.userNotFound)
            } else {
                getString(.unknownError)
            }
        }
    }
    
    struct ConversationUiState {
        var conversations: [ConversationUi] = []
        var loading = true
    }
}
