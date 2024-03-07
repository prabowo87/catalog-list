//
//  FavoriteSwiftData.swift
//  CatalogList
//
//  Created by Hermawan Prabowo on 07/03/24.
//

import Foundation
import SwiftData

@Model
final class FavoriteSwiftData : ObservableObject, Identifiable{
    var id: Int
    var title: String
    var descriptions: String
    var price: Int?
    var discountPercentage  : Double?
    var rating  : Double?
    var stock  : Double?
    var brand  : String?
    var category: String?
    var thumbnail: String
    var images : Array<String>
    var isFavorite:Bool? = false
    
    init(id: Int, title: String, descriptions: String, price : Int?, discountPercentage: Double?,
         rating: Double?,stock: Double?, brand: String?, category: String?, thumbnail: String, images: Array<String>, isFavorite: Bool?=false) {
        self.id = id
        self.title = title
        self.descriptions = descriptions
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
        self.isFavorite = isFavorite
    }
    
}
