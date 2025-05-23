import Foundation
import Combine

class LogoutUseCase {
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    func execute() async {
        await authenticationRepository.logout()
    }
}
