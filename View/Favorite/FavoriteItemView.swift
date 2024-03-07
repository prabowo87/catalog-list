//
//  FavoriteItemView.swift
//  CatalogList
//
//  Created by Hermawan Prabowo on 07/03/24.
//

import SwiftUI
import SwiftData
import URLImage

struct FavoriteItemView: View {
    @Environment(\.modelContext) private var modelContext
//     @Query static var favoriteData: [FavoriteSwiftData]
    @Query  var localDatas: [FavoriteSwiftData]
    let cellWidth = UIScreen.main.bounds.width/2 - 20
    let cellHeight : CGFloat =  (UIScreen.main.bounds.width/2 - 32) * 1.75
     var productModel : FavoriteSwiftData
     var productModelPos : Int
    
    @StateObject
        private var someVM: HomeViewModel = .shared
    
    
    var body: some View {
        VStack {
            getProductItemView()
        }
    }
    
    func getProductItemView() -> some View{
        
       
        print(productModel.isFavorite as Any)
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
                
                Text(productModel.descriptions)
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
                    Image(systemName: (productModel.isFavorite ?? true) ? "heart.fill":"heart")
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
                
            }
        }
    }
}
    
 private func findLocalData(localDatas: [FavoriteSwiftData],productModel: FavoriteSwiftData,id: Int)  -> Any {
     var res = false
     for localData in localDatas {
        if id == localData.id {
            res=true
            break
        }
    }
     return res
}
    

private func addItem(productModel : FavoriteSwiftData, modelContext: ModelContext) {
//        withAnimation {
    let newItem = FavoriteSwiftData(id: productModel.id, title: productModel.title, descriptions: productModel.descriptions, price: productModel.price, discountPercentage: productModel.discountPercentage, rating: productModel.rating, stock: productModel.stock, brand: productModel.brand, category: productModel.category, thumbnail: productModel.thumbnail, images: productModel.images,isFavorite: productModel.isFavorite)
        modelContext.insert(newItem)
        do {
            try modelContext.save()
        }catch {
            print(error)
        }
       
    }

private func deleteItems(localDatas: [FavoriteSwiftData], offsets: FavoriteSwiftData, modelContext: ModelContext) {
//        withAnimation {
    var i : Int = 0
        for localData in localDatas {
            if offsets.id == localData.id {
                let row : FavoriteSwiftData = localData;             
                modelContext.delete(row)
                do {
                    try modelContext.save()
                }catch {
                    print(error)
                }
               break
           }
        i+=1
       }
        
    }

//#Preview {
//    FavoriteItemView()
//}
