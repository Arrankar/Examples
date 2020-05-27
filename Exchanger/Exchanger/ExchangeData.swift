//
//  ExchangeData.swift
//  Exchanger
//
//  Created by Александр on 21.05.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import Foundation

struct ExchangeData: Decodable {
    var asset_id_base: String
    var rate: Double
}
