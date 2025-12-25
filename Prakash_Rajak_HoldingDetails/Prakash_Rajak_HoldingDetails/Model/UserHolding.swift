//
//  UserHolding.swift
//  Prakash_Rajak_HoldingDetails
//
//  Created by Prakash Rajak on 24/12/25.
//


import Foundation
struct UserHolding : Codable {
	let symbol : String
	let quantity : Int
	let ltp : Double
    let avgPrice : Double
    let close : Double

	enum CodingKeys: String, CodingKey {
		case symbol = "symbol"
		case quantity = "quantity"
		case ltp = "ltp"
		case avgPrice = "avgPrice"
		case close = "close"
	}
}
