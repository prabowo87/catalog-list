//
//  ResponseProductModel.swift
//  CatalogList
//
//  Created by Hermawan Prabowo on 06/03/24.
//

import Foundation
import SwiftUI
struct ResponseProductModel:  Codable {
    var products: [ProductModel]    
    var total: Int
    var skip: Int
    var limit: Int
   
        
    
}
