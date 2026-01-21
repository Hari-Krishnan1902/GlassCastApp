//
//  ApiService.swift
//  Glasscast
//
//  Created by Hari on 20/1/26.
//

import Foundation
class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw AppError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw AppError.invalidResponse
            }
//            print("Api REsponse :\(response)")
            guard (200...299).contains(httpResponse.statusCode) else {
                if httpResponse.statusCode == 404 {
                    throw AppError.cityNotFound
                }
                throw AppError.invalidResponse
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(T.self, from: data)
            } catch {
                throw AppError.decodingError
            }
            
        } catch let error as AppError {
            throw error
        } catch {
            throw AppError.networkError(error)
        }
    }
}
