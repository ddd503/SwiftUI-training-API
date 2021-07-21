//
//  RepoRepositoryMock.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/07/21.
//

import Combine

struct RepoRepositoryMock: RepoRepository {
    let repos: [Repo]
    let error: Error?

    init(repos: [Repo] = [], error: Error? = nil) {
        self.repos = repos
        self.error = error
    }

    func fetchRepos() -> AnyPublisher<[Repo], Error> {
        if let error = error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }

        return Just(repos)
            .setFailureType(to: Error.self) // <Errorをセットしている、ないとNeverを返す>
            .eraseToAnyPublisher()
    }
}
