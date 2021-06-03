//
//  GithubAPIDataStore.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/06/03.
//

import Foundation
import Combine

final class GithubAPIDataStore {
    private let url = URL(string: "https://api.github.com/orgs/mixigroup/repos")!

    func publicRepos() -> URLSession.DataTaskPublisher {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/vnd.github.v3+json"
        ]
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
    }
}
