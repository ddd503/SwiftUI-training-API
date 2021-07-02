//
//  RepoListViewModel.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/06/25.
//

import Foundation
import Combine

final class RepoListViewModel: ObservableObject {

    @Published private(set) var state: Stateful<[Repo]> = .idle
    private let repoRepository: RepoRepository
    private var cancellables = Set<AnyCancellable>()

    init(repoRepository: RepoRepository = RepoRepositoryImpl(repoAPIClient: RepoAPIClientImpl())) {
        self.repoRepository = repoRepository
    }

    func onAppear() {
        loadRepos()
    }
    
    func onRetryButtonTapped() {
        loadRepos()
    }

    private func loadRepos() {
        repoRepository.fetchRepos()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.state = .loading
            })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    self?.state = .failed(error)
                case .finished: break
                }
            } receiveValue: { [weak self] (repos) in
                self?.state = .loaded(repos)
            }
            .store(in: &cancellables)
    }
}
