import Foundation

class UserOracleApiImpl: UserOracleApi {
    private let tag = String(describing: UserOracleApiImpl.self)
    
    private func baseUrl(endPoint: String) -> URL? {
        URL.oracleUrl(endpoint: "/users/" + endPoint)
    }
    
    func createUser(user: OracleUser) async throws -> (URLResponse, ServerResponse) {
        guard let url = baseUrl(endPoint: "create") else {
            throw NetworkError.invalidURL("Invalid URL")
        }
        
        let request = try RequestUtils.formatPostRequest(dataToSend: user, url: url)
        let session = RequestUtils.getUrlSession()
        
        let (dataReceived, response) = try await session.data(for: request)
        let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: dataReceived)
        return (response, serverResponse)
    }
    
    func updateProfilePictureFileName(userId: String, fileName: String) async throws -> (URLResponse, ServerResponse) {
        guard let url = baseUrl(endPoint: "profile-picture-file-name") else {
            throw NetworkError.invalidURL("Invalid URL")
        }
        
        let dataToSend: [String: String] = [
            OracleUserDataFields.userId: userId,
            OracleUserDataFields.userProfilePictureFileName: fileName
        ]
        
        let request = try RequestUtils.formatPutRequest(dataToSend: dataToSend, url: url)
        let session = RequestUtils.getUrlSession()
        
        let (dataReceived, response) = try await session.data(for: request)
        let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: dataReceived)
        return (response, serverResponse)
    }
    
    func deleteProfilePictureFileName(userId: String) async throws -> (URLResponse, ServerResponse) {
        guard let url = baseUrl(endPoint: "profile-picture-file-name/\(userId)") else {
            throw NetworkError.invalidURL("Invalid URL")
        }
        
        let request = try RequestUtils.formatDeleteRequest(url: url)
        let session = RequestUtils.getUrlSession()
        
        let (dataReceived, response) = try await session.data(for: request)
        let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: dataReceived)
        return (response, serverResponse)
    }
}
