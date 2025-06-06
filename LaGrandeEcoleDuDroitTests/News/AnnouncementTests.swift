import XCTest
import Combine
@testable import La_Grande_Ecole_Du_Droit

final class AnnouncementTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!
    private var announcementRepository: AnnouncementRepository!
    
    private var getAnnouncementUseCase: GetAnnouncementsUseCase!
    private var createAnnouncementUseCase: CreateAnnouncementUseCase!
    private var updateAnnouncementUseCase: UpdateAnnouncementUseCase!
    private var deleteAnnouncementUseCase: DeleteAnnouncementUseCase!
        
    override func setUp() {
        cancellables = []
        announcementRepository = NewsInjection.shared.resolveWithMock().resolve(AnnouncementRepository.self)
        
        getAnnouncementUseCase = GetAnnouncementsUseCase(announcementRepository: announcementRepository)
        createAnnouncementUseCase = CreateAnnouncementUseCase(announcementRepository: announcementRepository)
        updateAnnouncementUseCase = UpdateAnnouncementUseCase(announcementRepository: announcementRepository)
        deleteAnnouncementUseCase = DeleteAnnouncementUseCase(announcementRepository: announcementRepository)
    }
    
    func testGetAnnouncements() async throws {
        // Given
        let expectation = XCTestExpectation(description: #function)
        var result: [Announcement] = []
        
        // When
        getAnnouncementUseCase.execute().sink { value in
            result = value
            expectation.fulfill()
        }.store(in: &cancellables)
        
        // Then
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertTrue(result == announcementsFixture)
    }
    
    func testCreateAnnouncement() async throws {
        // Given
        let expectation = XCTestExpectation(description: #function)
        var result: Announcement?
        let announcement = announcementFixture.with(id: "0000", content: "Hello World")
        
        // When
        try await createAnnouncementUseCase.execute(announcement: announcement)
        announcementRepository.announcements.sink { value in
            result = value.first { $0.id == announcement.id }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        // Then
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(result?.id, announcement.id)
    }
    
    func testUpdateAnnouncement() async throws {
        // Given
        let expectation = XCTestExpectation(description: #function)
        var result: Announcement?
        let announcement = announcementFixture.with(id: "0000", content: "Hello World")
        let announcementUpdated = announcement.with(content: "Hola el mondo")

        // When
        try await createAnnouncementUseCase.execute(announcement: announcement)
        try await updateAnnouncementUseCase.execute(announcement: announcementUpdated)
        
        announcementRepository.announcements.sink { value in
            result = value.first { $0.id == announcement.id }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        // Then
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(result?.content, announcementUpdated.content)
    }
    
    func testDeleteAnnouncement() async throws {
        // Given
        let expectation = XCTestExpectation(description: #function)
        var result: Announcement?
        let announcement = announcementFixture.with(id: "0000", content: "Hello World")

        // When
        try await createAnnouncementUseCase.execute(announcement: announcement)
        try await deleteAnnouncementUseCase.execute(announcement: announcement)
        
        announcementRepository.announcements.sink { value in
            result = value.first { $0.id == announcement.id }
            expectation.fulfill()
        }.store(in: &cancellables)
        
        // Then
        await fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(result, nil)
    }
}
