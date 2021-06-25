//
//  RepoAPIClient.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/06/25.
//

import Foundation
import Combine

protocol RepoAPIClient {
    func getRepos() -> AnyPublisher<[PublicRepository], Error>
}

struct RepoAPIClientImpl: RepoAPIClient {
    func getRepos() -> AnyPublisher<[PublicRepository], Error> {
        let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/vnd.github.v3+json"
        ]

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: [PublicRepository].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
