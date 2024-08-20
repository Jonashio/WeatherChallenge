//
//  GetForecastUseCase.swift
//  WeatherChallenge
//
//  Created by Jonashio on 16/8/24.
//

import Foundation


protocol UseCase {
    associatedtype T
    func execute(parameters: Codable) async -> Result<T, NetworkError>
}

struct GetForecastUseCase: UseCase {
    
    typealias T = ForescastResumenCity
    let repository: NetworkGeneric
    
    init(repository: NetworkGeneric = NetworkGeneric()) {
        self.repository = repository
    }
    
    func execute(parameters: Codable) async -> Result<T, NetworkError> {
        guard let parametersRequest = parameters as? ForecastRequestDTO else { return .failure(.unknown) }
        let resultResponse:Result<ForecastResponseDTO, NetworkError> = await repository.getData(profileEndpoint: .forecast(parametersRequest), builder: ForecastResponseDTO.builder())
        
        switch resultResponse {
        case .success(let model):
            return .success(ForescastResumenCity.builder(model))
        case .failure(let failure):
            return .failure(failure)
        }
    }
}
