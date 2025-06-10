import Combine
import Foundation

class UserRemoteDataSource {
    private let userFirestoreApi: UserFirestoreApi
    private let userOracleApi: UserOracleApi
    
    init(userFirestoreApi: UserFirestoreApi, userOracleApi: UserOracleApi) {
        self.userFirestoreApi = userFirestoreApi
        self.userOracleApi = userOracleApi
    }
    
    func listenUser(userId: String) -> AnyPublisher<User, Error> {
        userFirestoreApi.listenCurrentUser(userId: userId)
            .compactMap { $0?.toUser() }
            .eraseToAnyPublisher()
    }
    
    func getUser(userId: String) async throws -> User? {
        try await userFirestoreApi.getUser(userId: userId)?.toUser()
    }
    
    func getUserWithEmail(email: String) async throws -> User? {
        try await userFirestoreApi.getUserWithEmail(email: email)?.toUser()
    }
    
    func getUsers() async -> [User] {
        (try? await userFirestoreApi.getUsers())?.map { $0.toUser() } ?? []
    }
    
    func createUser(user: User) async throws {
        try await createUserWithOracle(user: user)
        try await createUserWithFirestore(user: user)
    }
    
    func updateProfilePictureFileName(userId: String, fileName: String) async throws {
        try await handleRetrofitError {
            try await userOracleApi.updateProfilePictureFileName(userId: userId, fileName: fileName)
        }
        
        userFirestoreApi.updateProfilePictureFileName(userId: userId, fileName: fileName)
    }
    
    func deleteProfilePictureFileName(userId: String) async throws {
        try await handleRetrofitError {
            try await userOracleApi.deleteProfilePictureFileName(userId: userId)
        }
        userFirestoreApi.deleteProfilePictureFileName(userId: userId)
    }
    
    private func createUserWithFirestore(user: User) async throws {
        try await handleNetworkException {
            try userFirestoreApi.createUser(firestoreUser: user.toFirestoreUser())
        }
    }
    
    private func createUserWithOracle(user: User) async throws {
        try await handleRetrofitError(
            block: { try await userOracleApi.createUser(user: user.toOracleUser()) },
            specificHandle: { urlResponse, serverResponse in
                if let httpResponse = urlResponse as? HTTPURLResponse {
                    if httpResponse.statusCode == 403 {
                        throw NetworkError.forbidden
                    }
                    throw parseOracleError(code: serverResponse.code, message: serverResponse.message)
                }
            }
        )
    }
}
