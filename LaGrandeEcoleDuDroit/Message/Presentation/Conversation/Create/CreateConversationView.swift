import SwiftUI

struct CreateConversationDestination: View {
    let onCreateConversationClick: (Conversation) -> Void
    
    @StateObject private var viewModel = MessageInjection.shared.resolve(CreateConversationViewModel.self)
    @EnvironmentObject private var tabBarVisibility: TabBarVisibility
    
    @State private var errorMessage: String = ""
    
    var body: some View {
        CreateConversationView(
            users: viewModel.uiState.users,
            loading: viewModel.uiState.loading,
            userQuery: viewModel.uiState.query,
            onQueryChange: viewModel.onQueryChange,
            onUserClick: { user in
                Task {
                    if let conversation = await viewModel.getConversation(interlocutor: user) {
                        onCreateConversationClick(conversation)
                    }
                }
            }
        )
    }
}

private struct CreateConversationView: View {
    let users: [User]
    let loading: Bool
    let userQuery: String
    let onQueryChange: (String) -> Void
    let onUserClick: (User) -> Void
    
    var body: some View {
        VStack {
            if loading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.top, GedSpacing.large)
            }
            else {
                if users.isEmpty {
                    Text(getString(.userNotFound))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                } else {
                    ScrollView {
                        ForEach(users, id: \.id) { user in
                            UserItem(
                                user: user,
                                onClick: { onUserClick(user) }
                            )
                        }
                    }
                }
            }
        }
        .navigationTitle(getString(.newConversation))
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .searchable(
            text: Binding(
                get: { userQuery },
                set: onQueryChange
            ),
            placement: .navigationBarDrawer(displayMode: .always)
        )
    }
}

#Preview {
    NavigationStack {
        CreateConversationView(
            users: usersFixture,
            loading: false,
            userQuery: "",
            onQueryChange: {_ in },
            onUserClick: {_ in }
        )
    }
}
