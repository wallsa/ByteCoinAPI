//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdateCoin(_ coinManager: CoinManager, _ coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = K.apiKey
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate : CoinManagerDelegate?
    
    func getCoinPrice(for currency:String){
        let urlString = "\(baseURL)/\(currency)\(apiKey)"
        performRequest(with: urlString)
        
    }
    
    func performRequest(with urlString:String){
        //1. Criar um URL
        guard let url = URL(string: urlString) else {return}
        //2. Criar um URLSession
        let session = URLSession(configuration: .default)
        //3.Dar a Sessão uma tarefa
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                delegate?.didFailWithError(error: error!)
                return
            }
            guard let safeData = data else {return}
            guard let coin = self.parseJSON(safeData) else {return}
            delegate?.didUpdateCoin(self, coin)
        }
        //4.Começar a tarefa
        task.resume()
    }
    func parseJSON(_ coinData: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(CoinData.self, from: coinData)
            let coin = decoderData.asset_id_base
            let currency = decoderData.asset_id_quote
            let price = decoderData.rate
            
            let coinModel = CoinModel(btc: coin, currency: currency, price: price)
            return coinModel
            
            
        }catch{
            print(error)
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
