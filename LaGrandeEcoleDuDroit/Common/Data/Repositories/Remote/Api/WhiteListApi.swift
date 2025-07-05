import Foundation

protocol WhiteListApi {
    func isUserWhiteListed(email: String) async throws -> (URLResponse, Bool)
}
