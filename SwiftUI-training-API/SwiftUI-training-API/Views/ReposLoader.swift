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
    private let repoRepository: RepoRepository
    private var cancellables = Set<AnyCancellable>()

    init(repoRepository: RepoRepository = RepoRepositoryImpl(repoAPIClient: RepoAPIClientImpl())) {
        self.repoRepository = repoRepository
    }

    func call() {
        repoRepository.fetchRepos()
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
            }, receiveValue: { [weak self] repos in
                self?.state = .loaded(repos)
            }
            ).store(in: &cancellables)
    }
}
