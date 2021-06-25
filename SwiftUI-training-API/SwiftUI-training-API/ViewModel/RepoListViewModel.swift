//
//  RepoListViewModel.swift
//  SwiftUI-training-API
//
//  Created by kawaharadai on 2021/06/25.
//

import Foundation
import Combine

protocol RepoListViewModel: ObservableObject {
    func onAppear()
    func onRetryButtonTapped()
}

final class RepoListViewModelImpl: RepoListViewModel {
    func onAppear() {}
    func onRetryButtonTapped() {}
}
