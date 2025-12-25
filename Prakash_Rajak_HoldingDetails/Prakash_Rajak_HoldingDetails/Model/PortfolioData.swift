//
//  PortfolioData.swift
//  Prakash_Rajak_HoldingDetails
//
//  Created by Prakash Rajak on 24/12/25.
//


import Foundation
struct PortfolioData : Codable {
	let userHolding : [UserHolding]?

	enum CodingKeys: String, CodingKey {
		case userHolding = "userHolding"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		userHolding = try values.decodeIfPresent([UserHolding].self, forKey: .userHolding)
	}
}
