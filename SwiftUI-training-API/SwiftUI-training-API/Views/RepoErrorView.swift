//
//  RepoErrorView.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/06/04.
//

import SwiftUI

struct RepoErrorView: View {
    let retryAction: () -> Void

    var body: some View {
        VStack {
            Group {
                Image("GitHubMark")
                Text("Failed to load repositories")
                    .padding(.top, 4)
            }
            .foregroundColor(.black)
            .opacity(0.4)
            Button(action: {
                retryAction()
            }, label: {
                Text("Retry")
                    .fontWeight(.bold)
            })
            .padding(.top, 8)
        }
    }
}

struct RepoErrorView_Previews: PreviewProvider {
    static var previews: some View {
        RepoErrorView(retryAction: {})
    }
}
