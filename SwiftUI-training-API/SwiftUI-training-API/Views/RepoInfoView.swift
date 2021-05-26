//
//  RepoInfoView.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/05/23.
//

import SwiftUI

struct RepoInfoView: View {
    let repo: Repo

    var body: some View {
        HStack {
            Image("GitHubMark")
                .resizable()
                .frame(width: 44.0, height: 44.0)
            VStack(alignment: .leading) {
                Text(repo.owner.name)
                    .font(.caption)
                Text(repo.name)
                    .font(.body)
                    .fontWeight(.semibold)
            }
        }
    }
}
