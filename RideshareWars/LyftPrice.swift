//
//  LyftPrice.swift
//  RideshareWars
//
//  Created by Luke Newman on 8/2/16.
//  Copyright © 2016 Luke Newman. All rights reserved.
//

import Freddy

public struct LyftPrice {
    let rideType: String
    let estimatedCostMin: Int
    let estimatedCostMax: Int
}

extension LyftPrice: JSONDecodable {
    public init(json: JSON) throws {
        rideType = try json.string("display_name")
        estimatedCostMin = try json.int("estimated_cost_cents_min")
        estimatedCostMax = try json.int("estimated_cost_cents_max")
    }
}
