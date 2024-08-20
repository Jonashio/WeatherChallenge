//
//  GetForecastUseCaseTests.swift
//  WeatherChallengeTests
//
//  Created by Jonashio on 20/8/24.
//

import XCTest
@testable import WeatherChallenge

final class GetForecastUseCaseTests: XCTestCase {

    var mockRepository: MockNetworkGeneric!
    var useCase: GetForecastUseCase!

    override func setUp() {
        super.setUp()
        mockRepository = MockNetworkGeneric()
        useCase = GetForecastUseCase(repository: mockRepository)
        
        
    }

    override func tearDown() {
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }

    // Test: Caso exitoso
    func testExecuteWithSuccess() async {
        // Arrange
        let expectedCity = "Barcelona"
        mockRepository.successLoadData()
        
        // Act
        let result = await useCase.execute(parameters: ForecastRequestDTO.init(q: "test"))

        // Assert
        switch result {
        case .success(let city):
            XCTAssertEqual(city.cityName, expectedCity)
        case .failure:
            XCTFail("Expected success, got failure instead")
        }
    }

    // Test: Caso fallido por error de red
    func testExecuteWithNetworkError() async {
        // Arrange
        mockRepository.errorLoadData()
        
        // Act
        let result = await useCase.execute(parameters: ForecastRequestDTO.init(q: "test"))

        // Assert
        switch result {
        case .success:
            XCTFail("Expected failure, got success instead")
        case .failure(let error):
            XCTAssertEqual(error.description, NetworkError.unknown.description)
        }
    }
}
