//
//  NetworkGeneric.swift
//  WeatherChallenge
//
//  Created by Jonashio on 15/8/24.
//

import Foundation
import CoreData

public enum NetworkError:Error {
    case general(Error)
    case dataError(Error)
    case httpError
    case URLInvalid
    case unknown

    public var description:String {
        switch self {
        case let .general(error):
            return "General error \(error.localizedDescription)."
        case .dataError(let error):
            return "Error parse data: \(error.localizedDescription)."
        case .httpError:
            return "HTTP error"
        case .URLInvalid:
            return "Invalid URL"
        case .unknown:
            return "Unknown error"
        }
    }
}

class NetworkGeneric {

    struct StatusCode {
        static let success = 200...299
    }
    
    var predefinedDataTest: Data?
    
    init(predefinedDataTest: Data? = nil) {
        self.predefinedDataTest = predefinedDataTest
    }
    
    func getData<Type>(profileEndpoint: NetworkManager, builder: ((Data) throws -> Type), keeper: ((Data) -> Void)? = nil) async -> Result<Type, NetworkError> {
        
        guard predefinedDataTest == nil else {
            guard let data = try? builder(predefinedDataTest!) else { return .failure(.unknown) }
            return .success(data)
        }
        
        printRequest(profileEndpoint)
        do {
            guard let url = URL(string: profileEndpoint.scheme + "://" + profileEndpoint.urlBase + profileEndpoint.path + profileEndpoint.parametersPath) else { return .failure(.URLInvalid) }
            //Configuration Request
            var request = URLRequest(url: url)
            request.httpMethod = profileEndpoint.method.rawValue

            profileEndpoint.contentType.isEmpty ? () : request.setValue(profileEndpoint.contentType, forHTTPHeaderField: "Content-Type")
            profileEndpoint.accept.isEmpty ? () : request.setValue(profileEndpoint.accept, forHTTPHeaderField: "Accept")
            
            request.httpBody = profileEndpoint.parametersBody
            
            let successTupla = try await getData(request: request, builder: builder)
            printSuccess(profileEndpoint, responseData: successTupla.1)
            keeper?(successTupla.1)
            
            return .success(successTupla.0)
        } catch let error as NetworkError {
            printError(profileEndpoint, error: error)
            return .failure(error)
        } catch {
            printError(profileEndpoint, error: NetworkError.general(error))
            return .failure(NetworkError.general(error))
        }
    }
    
    private func getData<Type>(request:URLRequest, builder:((Data) throws -> Type)) async throws -> (Type, Data) {
        do {
            let (data, response) = try await getURLSession(request).data(for: request)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.httpError }
            if StatusCode.success.contains(response.statusCode)  {
                do {
                    return try (builder(data), data)
                } catch {
                    throw NetworkError.dataError(error)
                }
            } else {
                throw NetworkError.httpError
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.general(error)
        }
    }
    
    private func getURLSession(_ request:URLRequest) -> URLSession {
        let isFile: Bool = request.url?.pathExtension.elementsEqual("") == false
        return isFile ? URLSession(configuration: URLSessionConfiguration.ephemeral) : URLSession.shared
    }
    
    private func printRequest(_ profileEndpoint: NetworkManager) {
        print("***********************************************************************************")
        print("REQUEST 🔵 \(String(describing: profileEndpoint.method.rawValue)) \(String(describing: profileEndpoint.scheme + "://" + profileEndpoint.urlBase + profileEndpoint.path + profileEndpoint.parametersPath))")
        if let bodyData = profileEndpoint.parametersBody {
            print(NSString(string: "PARAMS: \(String(data: bodyData, encoding: .utf8) ?? "")"))
        }
    }
    
    private func printSuccess(_ profileEndpoint: NetworkManager, responseData: Data) {
        print("SUCCESS 🟢 \(String(describing: profileEndpoint.method.rawValue)) \(String(describing: profileEndpoint.scheme + "://" + profileEndpoint.urlBase + profileEndpoint.path + profileEndpoint.parametersPath))")
        if let response_mode = ProcessInfo.processInfo.environment["RESPONSE_MODE"], response_mode.elementsEqual("enable") {
            print(NSString(string: "RESPONSE: \(String(data: responseData, encoding: .utf8) ?? "")"))
        }
        print("***********************************************************************************")
    }
    
    private func printError(_ profileEndpoint: NetworkManager, error: NetworkError) {
        print("ERROR 🔴 \(String(describing: profileEndpoint.method.rawValue)) \(String(describing: profileEndpoint.scheme + "://" + profileEndpoint.urlBase + profileEndpoint.path + profileEndpoint.parametersPath))")
        print(error.description)
        print("***********************************************************************************")
    }
}
