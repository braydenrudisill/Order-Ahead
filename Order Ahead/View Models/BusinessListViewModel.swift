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
    private static var numInstances = 0
  @Published var businessViewModels: [BusinessViewModel] = []
  private var cancellables: Set<AnyCancellable> = []

  @Published var businessRepository = BusinessRepository()

  init() {
    BusinessListViewModel.numInstances += 1
    print("Number of List View Models: \(BusinessListViewModel.numInstances)")
    businessRepository.$businesses.map { business in
      business.map(BusinessViewModel.init)
    }
    .assign(to: \.businessViewModels, on: self)
    .store(in: &cancellables)
  }

  func add(_ business: Business) -> String{
    return businessRepository.add(business)
  }
}
