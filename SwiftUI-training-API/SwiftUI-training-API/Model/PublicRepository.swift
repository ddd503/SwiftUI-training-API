//
//  PublicRepository.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/06/03.
//

import Foundation

struct PublicRepository: Decodable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int
    let owner: Owner

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case stargazersCount = "stargazers_count"
        case owner
    }
}

struct Owner: Decodable {
    let login: String
}
