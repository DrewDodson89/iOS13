//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didGetCoinPrice(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {

    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "952B1166-B523-43E4-B17F-20E3B8DAC674"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for selectedCurrency: String) {
        
        let completedURL = "\(baseURL)/\(selectedCurrency)?apikey=\(apiKey)"
        if let url = URL(string: completedURL) {
            let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let coin = self.parseJSON(safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.didGetCoinPrice(self, coin: coin)
                        }
                    }
                }
            }
            task.resume()
        }
    }


    func parseJSON(_ coinData: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            let coin = CoinModel(currency: currency, rate: rate)
            return coin
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
