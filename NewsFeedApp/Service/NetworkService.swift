//
//  NetworkService.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/4/21.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    private let urlSession = URLSession.shared
    private let baseUrl = URL(string: "\(Settings.hostname)/api/w5/")
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    enum Endpoint: String, CaseIterable {
        case search
    }
    
    enum NetworkServiceError: Error {
        case apiError
        case noData
        case invalidEndpoint
        case invalidResponse
        case decodeError
    }
    
    private func fetchData<T: Decodable>(url: URL?, completion: @escaping (Result<T, NetworkServiceError>) -> Void) {
        guard let url = url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        urlSession.dataTask(with: url) { result in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(.decodeError))
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                completion(.failure(.apiError))
            }
        }.resume()
     
    }
    
    enum Queries: String {
        case chrono
        case page
        case perPage = "per_page"
        case locale
    }
    
    func fetchNewsFeed(fromPage pageNumber: Int, result: @escaping (Result<NewsFeedResponse, NetworkServiceError>) -> Void) {
        let endpoint: Endpoint = .search
        var url = baseUrl?.appendingPathComponent(endpoint.rawValue)
        
        let queries: [Queries : String] = [
                     .chrono  : "news",
                     .page    : String(pageNumber),
                     .perPage : String(20),
                     .locale  : "en"
        ]
        
        for query in queries {
            url?.appendQueryItem(name: query.key.rawValue, value: query.value)
        }
        fetchData(url: url, completion: result)
    }
    
    func fetchNewsDetails(fromLink link: String, result: @escaping (Result<NewsDetailsResponse, NetworkServiceError>) -> Void) {
        let url = baseUrl?.appendingPathComponent(link)
        fetchData(url: url, completion: result)
    }
}
