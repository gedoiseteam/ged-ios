import XCTest
@testable import La_Grande_Ecole_Du_Droit

final class AuthenticationViewModelTests: XCTestCase {
    
    
    private let authenticationViewModel = AuthenticationInjection.shared.resolve(AuthenticationViewModel.self)
    private let email = "email@example.com"
    private let password = "12345678"
    
    override func setUp() {
        
    }

    func test_default_values_are_correct() throws {
        // Then
        XCTAssertEqual(authenticationViewModel.email, "")
        XCTAssertEqual(authenticationViewModel.password, "")
        XCTAssertEqual(authenticationViewModel.authenticationState, AuthenticationState.idle)
    }
    
    func test_validateInputs_should_return_false_when_email_is_empty() {
        // When
        let result = authenticationViewModel.validateInputs()
        
        // Then
        XCTAssertFalse(result)
    }
    
    func test_validateInputs_should_return_false_when_password_is_empty() {
        // Given
        authenticationViewModel.email = email
        
        // When
        let result = authenticationViewModel.validateInputs()
        
        // Then
        XCTAssertFalse(result)
    }
    
    func test_validateInputs_should_return_false_when_email_is_incorrect() {
        // Given
        authenticationViewModel.email = "email"
        authenticationViewModel.password = password
        
        // When
        let result = authenticationViewModel.validateInputs()
        
        // Then
        XCTAssertFalse(result)
    }
    
    func test_validateInputs_should_return_false_when_password_length_is_less_than_8() {
        // Given
        authenticationViewModel.email = email
        authenticationViewModel.password = "1234567"
        
        // When
        let result = authenticationViewModel.validateInputs()
        
        // Then
        XCTAssertFalse(result)
    }

    func test_validate_inputs_should_return_true_when_email_and_password_are_correct() {
        // Given
        authenticationViewModel.email = email
        authenticationViewModel.password = password
        
        // When
        let result = authenticationViewModel.validateInputs()
        
        // Then
        XCTAssertTrue(result)
    }
    
    func test_login_should_reset_inputs() async {
        // Given
        authenticationViewModel.email = email
        authenticationViewModel.password = password
        
        // When
        await authenticationViewModel.login()
        
        // Then
        XCTAssertEqual(authenticationViewModel.email, "")
        XCTAssertEqual(authenticationViewModel.password, "")
    }
}
