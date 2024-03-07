//
//  ProductModel.swift
//  CatalogList
//
//  Created by Hermawan Prabowo on 06/03/24.
//

import Foundation
class ProductModel: ObservableObject, Codable, Identifiable {
    var id: Int
    var title: String
    var description: String?
    var price: Int?
    var discountPercentage  : Double?
    var rating  : Double?
    var stock  : Double?
    var brand  : String?
    var category: String?
    var thumbnail: String
    var images : Array<String>
    var isFavorite:Bool? = false
    
}
