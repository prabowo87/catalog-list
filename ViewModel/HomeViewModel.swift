//
//  HomeViewModel.swift
//  CatalogList
//
//  Created by Hermawan Prabowo on 06/03/24.
//
import Combine
import Foundation

class HomeViewModel: ObservableObject{
    static let shared: HomeViewModel = .init()
    enum ViewState {
        case START
        case LOADING
        case SUCCESS(products: [ProductModel])
        case FAILURE(error: String)
    }
    
    
        @Published var currentState: ViewState = .START
        @Published
        var bindingValue: [ProductModel] = []
        private var cancelables = Set<AnyCancellable>()

        init() {
            getProducts()
        }

    func getProducts() {
        self.currentState = .LOADING
        HomeService.shared.getProducts()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Execution Finihsed.")
                case .failure(let error):
                    self.currentState = .FAILURE(error: error.localizedDescription)
                }
            } receiveValue: { response in
                self.bindingValue = response.products
                
                self.currentState = .SUCCESS(products: response.products)
                
            }.store(in: &cancelables)
        
    }
    func updateFavorite (position:Int,isFavorite: Bool) {
        self.bindingValue[position].isFavorite = isFavorite
       
    }
    func updateFavoriteId (id:Int,isFavorite: Bool) {
        var idx : Int = 0;
        for data in  self.bindingValue {
            if data.id == id {
                self.bindingValue[idx].isFavorite = isFavorite
                break
            }
            idx+=1
        }
        
       
    }
}
