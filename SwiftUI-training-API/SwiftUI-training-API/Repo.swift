//
//  Repo.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/05/23.
//

import Foundation

struct Repo: Identifiable {
    var id: Int
    var name: String
    var owner: User
}
