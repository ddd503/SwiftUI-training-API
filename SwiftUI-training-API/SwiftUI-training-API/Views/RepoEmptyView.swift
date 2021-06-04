//
//  RepoEmptyView.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/06/04.
//

import SwiftUI

struct RepoEmptyView: View {
    var body: some View {
        Text("No repositories")
            .fontWeight(.bold)
            .font(.system(size: 30))
    }
}

struct RepoEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        RepoEmptyView()
    }
}
