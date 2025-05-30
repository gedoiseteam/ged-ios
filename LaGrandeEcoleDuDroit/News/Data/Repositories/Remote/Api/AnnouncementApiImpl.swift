import Foundation
import os

class AnnouncementApiImpl: AnnouncementApi {
    private func baseUrl(endPoint: String) -> URL? {
        URL.oracleUrl(endpoint: "/announcements" + endPoint)
    }
    
    func getAnnouncements() async throws -> [RemoteAnnouncementWithUser] {
        guard let url = baseUrl(endPoint: "") else {
            throw RequestError.invalidURL("Invalid URL")
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([RemoteAnnouncementWithUser].self, from: data)
    }
    
    func createAnnouncement(remoteAnnouncement: RemoteAnnouncement) async throws {
        guard let url = baseUrl(endPoint: "/create") else {
            throw RequestError.invalidURL("Invalid URL")
        }
        
        let session = RequestUtils.getUrlSession()
        let postRequest = try RequestUtils.formatPostRequest(dataToSend: remoteAnnouncement, url: url)
        
        let (dataReceived, response) = try await session.data(for: postRequest)
        let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: dataReceived)
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode >= 400 {
                throw RequestError.invalidResponse(serverResponse.error)
            }
        }
    }
    
    func deleteAnnouncement(remoteAnnouncementId: String) async throws {
        guard let url = baseUrl(endPoint: "/\(remoteAnnouncementId)") else {
            throw RequestError.invalidURL("Invalid URL")
        }
        
        let session = RequestUtils.getUrlSession()
        let deleteRequest = try RequestUtils.formatDeleteRequest(url: url)
        
        let (dataReceived, response) = try await session.data(for: deleteRequest)
        let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: dataReceived)
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode >= 400 {
                throw RequestError.invalidResponse(serverResponse.error)
            }
        }
    }
    
    func updateAnnouncement(remoteAnnouncement: RemoteAnnouncement) async throws {
        guard let url = baseUrl(endPoint: "/update") else {
            throw RequestError.invalidURL("Invalid URL")
        }
        
        let session = RequestUtils.getUrlSession()
        let postRequest = try RequestUtils.formatPostRequest(dataToSend: remoteAnnouncement, url: url)
        
        let (dataReceived, response) = try await session.data(for: postRequest)
        let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: dataReceived)
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode >= 400 {
                throw RequestError.invalidResponse(serverResponse.error)
            }
        }
    }
}
