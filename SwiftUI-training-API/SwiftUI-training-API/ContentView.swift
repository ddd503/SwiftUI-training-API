//
//  ContentView.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            Image("GitHubMark")
                .resizable()
                .frame(width: 44.0, height: 44.0)
            VStack(alignment: .leading) {
                Text("Owner Name")
                    .font(.caption)
                Text("Repository Name")
                    .font(.body)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
