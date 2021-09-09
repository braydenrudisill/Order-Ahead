//
//  BusinessViewModel.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 9/7/21.
//

import Foundation
import Combine

// 1
class BusinessViewModel: ObservableObject, Identifiable {
  // 2
  private let businessRepository = BusinessRepository()
  @Published var business: Business
  // 3
  private var cancellables: Set<AnyCancellable> = []
  // 4
  var id = ""

  init(business: Business) {
    self.business = business
    // 6
    $business
      .compactMap { $0.id }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)
  }

  func update(business: Business) {
    businessRepository.update(business)
  }

  func remove() {
    businessRepository.remove(business)
  }
}
