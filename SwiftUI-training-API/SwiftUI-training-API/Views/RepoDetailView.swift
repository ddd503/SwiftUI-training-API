//
//  RepoDetailView.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/05/24.
//

import SwiftUI

struct RepoDetailView: View {
    let repo: Repo

    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image("GitHubMark")
                            .resizable()
                            .frame(width: 20.0, height: 20.0)
                        Text(repo.owner.name)
                            .font(.caption)
                    }
                    Text(repo.name)
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Text(repo.description)
                        .font(.caption)
                        .padding(.top, 4)

                    HStack {
                        Image(systemName: "star")
                        Text("10 stars")
                            .font(.caption)
                    }
                    .padding(.top, 8)
                    Spacer()
                }
                Spacer()
            }
            .padding(8)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RepoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepoDetailView(repo: .mock1)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
            .previewDisplayName("iPhone SE")
    }
}
