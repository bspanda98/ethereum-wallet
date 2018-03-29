//
//  SendTokenCheckoutService.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov on 21/03/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Foundation

class SendTokenCheckoutService: SendCheckoutServiceProtocol {
  
  func checkout(for coin: CoinDisplayable, amount: Decimal, iso: String, fee: Decimal) throws -> Checkout {
    guard let rate = coin.rates.first(where: {$0.to == iso}) else {
      throw SendCheckoutError.noRate
    }
    
    let feeAmount = Ether(weiValue: fee)
    let feeAmountString = feeAmount.amountString
    
    let fiatAmount = Ether(amount)
    let fiatAmountString = FiatCurrencyFactory.amount(currency: fiatAmount, iso: iso, rate: rate.value)
    
    let ethAmountString = FiatCurrencyFactory.amount(amount: amount.double, currency: coin.balance)
    
    return (amount: ethAmountString, fiatAmount: fiatAmountString, fee: feeAmountString)
  }
}