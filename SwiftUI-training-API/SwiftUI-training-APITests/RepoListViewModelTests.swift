//
//  RepoListViewModelTests.swift
//  SwiftUI-training-APITests
//
//  Created by kawaharadai on 2021/07/17.
//

import XCTest
import Combine
@testable import SwiftUI_training_API

class RepoListViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    struct DummyError: Error {}

    override func setUpWithError() throws {
        cancellables = .init()
    }
    func test_onAppear_正常系_リポジトリ一覧を取得できること() {
        let expectedToBeLoading = expectation(description: "読み込み中のステータスになること")
        let expectedToBeLoaded = expectation(description: "期待通りリポジトリが読み込まれること")

        let viewModel = RepoListViewModel(
            repoRepository: RepoRepositoryMock(
                repos: [.mock1, .mock2]
            )
        )
        viewModel.$state.sink { result in
            switch result {
            case .loading:
                expectedToBeLoading.fulfill()
            case let .loaded(repos):
                if repos.count == 2 &&
                    repos.map({ $0.id }) == [Repo.mock1.id, Repo.mock2.id] {
                    expectedToBeLoaded.fulfill()
                } else {
                    XCTFail("Unexpected: \(result)")
                }
            default: break
            }
        }.store(in: &cancellables)

        viewModel.onAppear()

        wait(
            for: [expectedToBeLoading, expectedToBeLoaded],
            timeout: 2.0,
            enforceOrder: true // trueの場合は配列でセットしたexpectationを順に満たす必要がある
        )
    }

    func test_onAppear_異常系() {
        let expectedToBeLoading = expectation(description: "読み込み中のステータスになること")
        let expectedToBeFailure = expectation(description: "読み込みに失敗した時にエラーを取得できること")

        let dummyError = DummyError()
        let viewModel = RepoListViewModel(
            repoRepository: RepoRepositoryMock(
                repos: [.mock1, .mock2], error: dummyError
            )
        )
        viewModel.$state.sink { result in
            switch result {
            case .loading:
                expectedToBeLoading.fulfill()
            case let .failed(error):
                if error is DummyError {
                    expectedToBeFailure.fulfill()
                }
            default: break
            }
        }.store(in: &cancellables)

        viewModel.onAppear()

        wait(
            for: [expectedToBeLoading, expectedToBeFailure],
            timeout: 2.0,
            enforceOrder: true // trueの場合は配列でセットしたexpectationを順に満たす必要がある
        )
    }
}
