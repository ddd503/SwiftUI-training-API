//
//  ReposLoader.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/06/02.
//

import Foundation
import Combine

class ReposLoader: ObservableObject {
    @Published private(set) var repos = [Repo]()

    private var cancellables = Set<AnyCancellable>()

    func call() {
        let reposPublisher = Future<[Repo], Error> { promise in
            // 非同期処理を行う
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                promise(.success([
                    .mock1, .mock2, .mock3, .mock4, .mock5
                ]))
            }
        }
        reposPublisher
            .receive(on: DispatchQueue.main) // 非同期処理が流れてくるのでメインに戻す
            .sink(receiveCompletion: { completion in
                print("Finished: \(completion)")
            }, receiveValue: { [weak self] repos in
                self?.repos = repos
            }
            ).store(in: &cancellables)
    }
}
