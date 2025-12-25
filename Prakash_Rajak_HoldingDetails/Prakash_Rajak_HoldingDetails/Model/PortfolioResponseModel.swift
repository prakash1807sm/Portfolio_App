//
//  PortfolioResponseModel.swift
//  Prakash_Rajak_HoldingDetails
//
//  Created by Prakash Rajak on 24/12/25.
//


import Foundation
struct PortfolioResponseModel : Codable {
	let data : PortfolioData?

	enum CodingKeys: String, CodingKey {
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(PortfolioData.self, forKey: .data)
	}

}
