//
//  RepoListView.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/05/23.
//

import SwiftUI
import Combine

struct RepoListView: View {
    @StateObject private var viewModel: RepoListViewModel

    init(viewModel: RepoListViewModel = RepoListViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView("loading...")
                case .failed(_):
                    RepoErrorView(retryAction: {
                        viewModel.onRetryButtonTapped()
                    })
                case .loaded(let repos):
                    if repos.isEmpty {
                        RepoEmptyView()
                    } else {
                        List(repos) { repo in
                            NavigationLink(
                                destination: RepoDetailView(repo: repo)) {
                                RepoInfoView(repo: repo)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Repositories")
        }.onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RepoListView(viewModel: RepoListViewModel(repoRepository: RepoRepositoryMock(repos: [
                .mock1, .mock2, .mock3, .mock4, .mock5
            ])))
            .previewDisplayName("正常系")
            RepoListView(viewModel: RepoListViewModel(repoRepository: RepoRepositoryMock(repos: [])))
            .previewDisplayName("取得結果が0件")
            RepoListView(viewModel: RepoListViewModel(repoRepository: RepoRepositoryMock(error: NSError())))
            .previewDisplayName("取得時にエラーが発生")
        }
    }
}
