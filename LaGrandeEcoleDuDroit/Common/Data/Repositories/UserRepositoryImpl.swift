import Foundation
import Combine

private let tag = String(describing: UserRepositoryImpl.self)

class UserRepositoryImpl: UserRepository {
    private let userLocalDataSource: UserLocalDataSource
    private let userRemoteDataSource: UserRemoteDataSource
    private var cancellables = Set<AnyCancellable>()
    
    private(set) var currentUser = CurrentValueSubject<User?, Never>(nil)
    
    init(userLocalDataSource: UserLocalDataSource, userRemoteDataSource: UserRemoteDataSource) {
        self.userLocalDataSource = userLocalDataSource
        self.userRemoteDataSource = userRemoteDataSource
        userLocalDataSource.currentUser.sink { [weak self] user in
            self?.currentUser.send(user)
        }.store(in: &cancellables)
    }
    
    func createUser(user: User) async throws {
        do {
            try await userRemoteDataSource.createUser(user: user)
            userLocalDataSource.setCurrentUser(user: user)
        } catch {
            e(tag, error.localizedDescription, error)
            throw error
        }
    }
    
    func getUser(userId: String) async -> User? {
        await userRemoteDataSource.getUser(userId: userId)
    }
    
    func getUserWithEmail(email: String) async throws -> User? {
        try await userRemoteDataSource.getUserWithEmail(email: email)
    }
    
    func getUserPublisher(userId: String) -> AnyPublisher<User, Never> {
        userRemoteDataSource.listenUser(userId: userId)
    }
    
    func getUsers() async throws -> [User] {
        try await userRemoteDataSource.getUsers()
    }
    
    func getFilteredUsers(filter: String) async -> [User] {
        await userRemoteDataSource.getFilteredUsers(filter: filter)
    }
        
    
    func setCurrentUser(user: User) {
        userLocalDataSource.setCurrentUser(user: user)
    }
    
    func removeCurrentUser() {
        userLocalDataSource.removeCurrentUser()
    }
    
    func updateProfilePictureUrl(userId: String, profilePictureFileName: String) async throws {
        try await userRemoteDataSource.updateProfilePictureFileName(userId: userId, fileName: profilePictureFileName)
        userLocalDataSource.updateProfilePictureUrl(fileName: profilePictureFileName)
    }
}
