//
//  ReposLoader.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/06/02.
//

import Foundation
import Combine

class ReposLoader: ObservableObject {
    @Published private(set) var state: Stateful<[Repo]> = .idle

    private var cancellables = Set<AnyCancellable>()

    func call() {
        let reposPublisher = GithubAPIDataStore().publicRepos()
        reposPublisher
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: [PublicRepository].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // 非同期処理が流れてくるのでメインに戻す
            .handleEvents(receiveSubscription: { [weak self] _ in // イベントが流れる前に走る？
                self?.state = .loading
            })
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.state = .failed(error)
                case .finished:
                    print("正常に終了したため、receiveValueに値が流れる")
                }
            }, receiveValue: { [weak self] publicRepos in
                let repos = publicRepos.map {
                    Repo(id: $0.id,
                         name: $0.name,
                         owner: User(name: $0.owner.login),
                         description: $0.description ?? "",
                         stargazersCount: $0.stargazersCount)
                }
                self?.state = .loaded(repos)
            }
            ).store(in: &cancellables)
    }
}
