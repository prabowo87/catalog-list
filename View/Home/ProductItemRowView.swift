//
//  ProductItemRowView.swift
//  CatalogList
//
//  Created by Hermawan Prabowo on 06/03/24.
//

import SwiftUI
import URLImage
import SwiftData

struct ProductItemRowView: View {
    @Environment(\.modelContext) private var modelContext
//     @Query static var favoriteData: [FavoriteSwiftData]
    @Query  var localDatas: [FavoriteSwiftData]
    let cellWidth = UIScreen.main.bounds.width/2 - 20
    let cellHeight : CGFloat =  (UIScreen.main.bounds.width/2 - 32) * 1.75
     var productModel : ProductModel
     var productModelPos : Int
    
    @StateObject
        private var someVM: HomeViewModel = .shared
    
    
    var body: some View {
        VStack {
            getProductItemView()
        }
    }
    
    func getProductItemView() -> some View{
        
       
        
        return ZStack {
            RoundedRectangle(cornerRadius: 30).frame(width: cellWidth, height: cellHeight, alignment: .center).foregroundColor(Util.getColor(Constants.COLOR_ACCENT_GREEN))
            
            
            VStack {
                
                URLImage(
                    url:URL(string: productModel.thumbnail)!,
                    inProgress: { progress in
                        ProgressView()
                    },
                    failure: { error, retry in
                        Text("Failed")
                    }
                ) { image in
                    image
                        .resizable()
//                        .renderingMode(.original)
//                        .aspectRatio(contentMode: .fill)
//                        .scaledToFit()
//                        .cornerRadius(30)
                        .frame(width: self.cellWidth, height: 120, alignment: .top)
                }
                
                HStack {
                    Text(productModel.title)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                        .foregroundColor(Color.fromHex(Constants.COLOR_BLACK))
                    
                    Spacer()
                }
                
                Text(productModel.description ?? "")
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .foregroundColor(Color.fromHex(Constants.COLOR_GREY_600))
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .frame(width: cellWidth, height: 30, alignment: .leading)
                
                HStack {
                    VStack {
                        
                        Text(Util.getFormattedPrice(price: productModel.price))
                            .font(.headline).foregroundColor(Color.fromHex(Constants.COLOR_BLACK))
                        
                        
                        
                    }.padding(.leading)
                    
                    Spacer()
                    
                    
                    
                }.padding(.top)
                
                Spacer()
                
            }.frame(width: cellWidth, height: cellHeight, alignment: .center)
            VStack {
                HStack{
                    Spacer()
                    Image(systemName: (productModel.isFavorite ?? false) ? "heart.fill":"heart")
                        .foregroundColor(.green)
                        
                        .padding(.all, 10)
                        .background(Rectangle()
                            .frame(width: 40, height: 40, alignment: .center)
                            .foregroundColor(Color.white)
                            .opacity(0.9)
                        )
                        .clipShape(Circle())
                        .padding(.all, 10)
//                        .opacity(0.7)
                    
                }.frame(width: cellWidth, height: 40, alignment: .center)
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                let isFavorite = findLocalData(localDatas: localDatas,productModel: productModel, id: productModel.id)
                if (isFavorite as! Bool == true){
                    
                    deleteItems(localDatas:localDatas,offsets:productModel,modelContext: modelContext)
                }else{
                    addItem(productModel: productModel,modelContext: modelContext)
                }
                if (productModel.isFavorite == true){
                    someVM.updateFavorite(position: productModelPos, isFavorite: false)
                }else{
                    someVM.updateFavorite(position: productModelPos, isFavorite: true)
                }
                
                someVM.objectWillChange.send()
                print(productModelPos)
//                productModel.objectWillChange.send()
            }
        }
    }
}
    
 func findLocalData(localDatas: [FavoriteSwiftData],productModel: ProductModel,id: Int)  -> Any {
     var res = false
     for localData in localDatas {
        if id == localData.id {
            res=true
            break
        }
    }
     return res
}
    

private func addItem(productModel : ProductModel, modelContext: ModelContext) {
//        withAnimation {
        let newItem = FavoriteSwiftData(id: productModel.id, title: productModel.title, descriptions: productModel.description ?? "", price: productModel.price, discountPercentage: productModel.discountPercentage, rating: productModel.rating, stock: productModel.stock, brand: productModel.brand, category: productModel.category, thumbnail: productModel.thumbnail, images: productModel.images)
        modelContext.insert(newItem)
        do {
            try modelContext.save()
        }catch {
            print(error)
        }
       
    }

private func deleteItems(localDatas: [FavoriteSwiftData], offsets: ProductModel, modelContext: ModelContext) {
//        withAnimation {
    var i : Int = 0
        for localData in localDatas {
            if offsets.id == localData.id {
                let row : FavoriteSwiftData = localData;             modelContext.delete(row)
                do {
                    try modelContext.save()
                }catch {
                    print(error)
                }
               break
           }
        i+=1
       }
        @Query(filter: #Predicate<FavoriteSwiftData> { productModel in
            if productModel.id == offsets.id{
                modelContext.delete(productModel)
                modelContext.save()
                return true
            }
            
            return false
        }) var _: Bool
           
//        }
    }
    //MARK:- Extension functions for views
    extension View {
        
        //coupon background
        func backgroundCoupon(cellWidth: CGFloat, cellHeight: CGFloat) -> some View {
            self.background(RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.white).opacity(0.8)
                .frame(width: cellWidth - 42, height: 30, alignment: .center))
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.fromHex(Constants.COLOR_ACCENT_GREEN), lineWidth: 2)
                    .frame(width: cellWidth - 42, height: 30, alignment: .center))
        }
        
    }

    struct ProductItemRowView_Previews: PreviewProvider {
        static var previews: some View {
            Group{
//                ProductItemRowView(groceryItemModel: LocalDataHandler.productsData[0])
//                ProductItemRowView(groceryItemModel: LocalDataHandler.productsData[1])
            }.previewLayout(.fixed(width: 300, height: 270))
        }
    }
