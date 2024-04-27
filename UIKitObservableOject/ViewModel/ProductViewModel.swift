//
//  ProductViewModel.swift
//  UIKitObservableOject
//
//  Created by Angelos Staboulis on 27/4/24.
//

import Foundation
class ProductViewModel:ObservableObject{
    let productServices = ProductServices()
    func getAllProducts() async throws -> [Product] {
        return  try await productServices.fetchProducts()
    }

}
