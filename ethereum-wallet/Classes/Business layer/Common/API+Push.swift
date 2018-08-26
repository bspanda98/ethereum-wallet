//
//  API+Push.swift
//  ethereum-wallet
//
//  Created by Artur Guseinov 01/06/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

import Alamofire

extension API {
  
  enum Push {
    case register(token: String, address: String)
    case unregister
  }
  
}

extension API.Push: APIMethodProtocol {
  
  var method: HTTPMethod {
    return .post
  }
  
  var path: String {
    switch self {
    case .register:
      return Defaults.chain.backend + "/push/register"
    case .unregister:
      return Defaults.chain.backend + "/push/unregister"
    }
  }
  
  var params: Params? {
    switch self {
    case .register(let token, let address):
      return [
        "wallets": [address],
        "deviceID": UUID().uuidString.lowercased(),
        "token": token
      ]
    case .unregister:
      return [
        "deviceID": UUID().uuidString.lowercased()
      ]
    }
  }
  
}