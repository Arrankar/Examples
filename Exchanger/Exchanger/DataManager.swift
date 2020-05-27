//
//  DataManager.swift
//  Exchanger
//
//  Created by Александр on 21.05.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateData(data: Double, firstCurrency: String, secondCurrency: String)
}

struct DataManager {
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "A4537CBE-C35C-464A-A86C-E5795B45CF52"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR", "BTC"]
    
    func getCoinPrice(for firstCurrency: String, in secondCurrency: String) {
        
        let urlString = "\(baseURL)/\(firstCurrency)/\(secondCurrency)?apikey=\(apiKey)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let coinData = self.parseJSON(coinData: safeData) {
                        self.delegate?.didUpdateData(data: coinData, firstCurrency: firstCurrency, secondCurrency: secondCurrency)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(coinData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ExchangeData.self, from: coinData)
            let rate = decodedData.rate
            return rate
        } catch {
            print(error)
            return nil
        }
    }
}
