//
//  MainView.swift
//  CatalogList
//
//  Created by Hermawan Prabowo on 06/03/24.
//

import SwiftUI
import URLImage
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var localData: [FavoriteSwiftData]
    let iconSizeSearch : CGFloat = 24
    let screenWidth = UIScreen.main.bounds.width/2 - 32
//    @ObservedObject var homeViewModel = HomeViewModel()
    @StateObject
        private var someVM: HomeViewModel = .shared
    var body: some View {
        NavigationView {
            
            VStack() {
                
                ToolbarView(hasNavigation: false)
                SearchView()
                GeometryReader { geometry in
                            if case .LOADING = someVM.currentState {
                                LoaderView()
                            } else if case .SUCCESS(let products) = someVM.currentState {
//                                List(products) { product in
                                productItemGrid(products: someVM.bindingValue, total: someVM.bindingValue.count )
//                                        .frame(width: geometry.size.width, height: 120)
//                                }
                            } else if case .FAILURE(let error) = someVM.currentState {
                                VStack(alignment: .center) {
                                    Spacer()
                                    Text(error)
                                        .font(.headline.bold())
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                }
                                .padding()
                            }
                }
                
                Spacer()
                
            }.navigationBarTitle("").navigationBarHidden(true)
        }
    }
    private func updateFavorite(id: Int,productModelPos: Int) {
        var position : Int = 0
        localData.forEach { movie in
            if id == movie.id {
                let dataApi: () = someVM.updateFavorite (position: productModelPos, isFavorite: true)
            }
            
            position+=1
                
        }
//        someVM.objectWillChange.send()
    }
    func productItemGrid(products: [ProductModel], total: Int) -> some View {
        GridStack(minCellWidth: screenWidth, spacing: 10, numItems: total,
                  alignment: .center) {  index, cellWidth in
            let _ = updateFavorite(id: products[index].id,productModelPos: index)
            
//            if movies.count > 0{
//                let _ = someVM.updateFavorite (position: idx, isFavorite: true)
//            }
            ProductItemRowView(productModel: products[index],productModelPos: index)
            
            
            
            
                
            }
                .background(Rectangle().foregroundColor(Util.getColor("#fafafa")))
    }
    
    func productItem(product: ProductModel) -> some View {
        VStack {
//            Spacer()
            HStack(spacing: 40) {
                
                URLImage(url: URL(string:  product.thumbnail )!,
                    inProgress: { progress in
                        ProgressView()
                    },
                    failure: { error, retry in
                        Text("Failed")
                    }) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
//                            .scaledToFill()
//                            .edgesIgnoringSafeArea(.all)
                            .frame(width: 80)
                }
                Spacer()
                VStack (alignment: HorizontalAlignment.leading){
                    Text(product.title)
                            .font(.headline)
//                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.leading)
                    Text(product.description ?? "")
//                            .font(.caption)
                    
                }
                
//                Spacer()
            } //.padding(.top, 10) .padding(.bottom,10)

//            Spacer()
        }
    }
}


//#Preview {
//    MainView()
//}
