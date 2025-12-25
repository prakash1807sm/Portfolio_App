//
//  ApiManager.swift
//  Prakash_Rajak_HoldingDetails
//
//  Created by Prakash Rajak on 24/12/25.
//

import Foundation
class ApiManager {
    func get<T>(_ url: URL, resultType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data else { return }
            do {
                completion(.success(try JSONDecoder().decode(T.self, from: data)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

protocol FetchHoldingResponse {
    func execute(completion: @escaping (Result<[UserHolding], Error>) -> Void)
}

final class FetchHoldingResponseForApi : FetchHoldingResponse {
    private let apiManager: ApiManager
    private let url = URL(string: "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/")!
    
    init(apiManager: ApiManager) {
        self.apiManager = apiManager
    }
    
    func execute(completion: @escaping (Result<[UserHolding], Error>) -> Void) {
        apiManager.get(url, resultType: PortfolioResponseModel.self) { result in
            completion(result.map { $0.data?.userHolding ?? [] })
        }
    }
}

final class FetchHoldingResponseForTest : FetchHoldingResponse {
    private let holdings: [UserHolding]
    
    init(_ holdings: [UserHolding]) {
        self.holdings = holdings
    }
    
    func execute(completion: @escaping (Result<[UserHolding], Error>) -> Void) {
        completion(.success(holdings))
    }
}
