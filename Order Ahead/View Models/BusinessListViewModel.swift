//
//  BusinessListViewModel.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/7/21.
//

import Foundation

import Combine

// 2
class BusinessListViewModel: ObservableObject {
  @Published var businessViewModels: [BusinessViewModel] = []
  private var cancellables: Set<AnyCancellable> = []

  @Published var businessRepository = BusinessRepository()

  init() {
    businessRepository.$businesses.map { business in
      business.map(BusinessViewModel.init)
    }
    .assign(to: \.businessViewModels, on: self)
    .store(in: &cancellables)
  }

  func add(_ business: Business) {
    businessRepository.add(business)
  }
}
