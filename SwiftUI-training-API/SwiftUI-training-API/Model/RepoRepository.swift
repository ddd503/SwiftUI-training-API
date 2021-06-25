//
//  RepoRepository.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/06/25.
//

import Combine

protocol RepoRepository {
    func fetchRepos() -> AnyPublisher<[Repo], Error>
}

struct RepoRepositoryImpl: RepoRepository {
    let repoAPIClient: RepoAPIClient

    func fetchRepos() -> AnyPublisher<[Repo], Error> {
        return repoAPIClient.getRepos()
            .map {
                $0.map {
                    Repo(id: $0.id,
                         name: $0.name,
                         owner: User(name: $0.owner.login),
                         description: $0.description ?? "",
                         stargazersCount: $0.stargazersCount)
                }
            }.eraseToAnyPublisher()
    }
}
