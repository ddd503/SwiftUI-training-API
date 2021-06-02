//
//  RepoListView.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/05/23.
//

import SwiftUI
import Combine

struct RepoListView: View {
//    @State private var reposLoader = ReposLoader()
    @StateObject private var reposLoader = ReposLoader()
    private var cancellables = Set<AnyCancellable>()

    var body: some View {
        NavigationView {
            if reposLoader.repos.isEmpty {
                ProgressView("loading...")
            } else {
                List(reposLoader.repos) { repo in
                    NavigationLink(
                        destination: RepoDetailView(repo: repo)) {
                        RepoInfoView(repo: repo)
                    }
                }
                .navigationTitle("Repositories")
            }
        }.onAppear(perform: {
            // ここがメインスレッドなのが悪い
            reposLoader.call()
        })
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView()
    }
}
