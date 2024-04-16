//
//  Products.swift
//  KimsWishList
//
//  Created by 민웅킴 on 4/15/24.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: URL
    let brand: String
    let category: String
    let discountPercentage: Double
    let images: [String]
    let rating: Double
    let stock: Int
    
}
