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
            // エラー発生時
            if reposLoader.error != nil {
                RepoErrorView(retryAction: {
                    reposLoader.call()
                })
                .navigationTitle("Repositories")
            } else {
                if reposLoader.isLoading {
                    ProgressView("loading...")
                } else {
                    // 通信完了後
                    if reposLoader.repos.isEmpty {
                        RepoEmptyView()
                            .navigationTitle("Repositories")
                    } else {
                        List(reposLoader.repos) { repo in
                            NavigationLink(
                                destination: RepoDetailView(repo: repo)) {
                                RepoInfoView(repo: repo)
                            }
                        }
                        .navigationTitle("Repositories")
                    }
                }
            }
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
