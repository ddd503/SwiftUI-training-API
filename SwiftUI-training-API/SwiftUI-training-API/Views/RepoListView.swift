//
//  RepoListView.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/05/23.
//

import SwiftUI
import Combine

struct RepoListView: View {
    @StateObject private var reposLoader = ReposLoader()
    private var cancellables = Set<AnyCancellable>()

    var body: some View {
        NavigationView {
            Group {
                switch reposLoader.state {
                case .idle, .loading:
                    ProgressView("loading...")
                case .failed(_):
                    RepoErrorView(retryAction: {
                        reposLoader.call()
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
            reposLoader.call()
        })
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
