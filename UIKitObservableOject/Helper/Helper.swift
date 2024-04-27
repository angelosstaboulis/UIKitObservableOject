//
//  Helper.swift
//  UIKitObservableOject
//
//  Created by Angelos Staboulis on 27/4/24.
//

import Foundation
class Helper{
    static let shared = Helper()
    private init(){}
    func createCurrencyField(currencyField:Any)->String{
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency
        guard let getCurrency = priceFormatter.string(for: currencyField) else{
            return ""
        }
        return getCurrency
    }
}
