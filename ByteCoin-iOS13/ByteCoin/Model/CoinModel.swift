//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Wallace Santos on 16/05/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let btc:String
    let currency:String
    let price:Double
    
    var priceString:String{
        return String(format: "%.2f", price)
    }
}
