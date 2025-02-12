import Combine

class IsAuthenticatedUseCase {
    private let authenticationRemoteRepository: AuthenticationRemoteRepository
    
    init(authenticationRemoteRepository: AuthenticationRemoteRepository) {
        self.authenticationRemoteRepository = authenticationRemoteRepository
    }
    
    func execute() -> AnyPublisher<Bool, Never> {
        authenticationRemoteRepository.isAuthenticated
    }
}
