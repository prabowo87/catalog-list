//
//  FavoriteView.swift
//  CatalogList
//
//  Created by Hermawan Prabowo on 07/03/24.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Query private var items: [FavoriteSwiftData]
    @StateObject
        private var someVM: HomeViewModel = .shared
    let iconSizeSearch : CGFloat = 24
    let screenWidth = UIScreen.main.bounds.width/2 - 32
    var body: some View {
        VStack() {
            Rectangle()
                            .edgesIgnoringSafeArea(.top)
                            .foregroundColor(Color.fromHex(Constants.COLOR_ACCENT_GREEN))
                            .frame(height: 0)
                            .navigationBarBackButtonHidden(true)
                            .navigationTitle("Favorite")
                            .font(.title)
                            .toolbar {
                                            ToolbarItem(placement: .navigationBarLeading) {
                                                Button {
                                                    someVM.objectWillChange.send()
//                                                    print("Custom Action")
                                                    // 2
                                                    mode.wrappedValue.dismiss()

                                                } label: {
                                                    HStack {
                                                        Image(systemName: "chevron.backward")
                                                        
                                                    }
                                                }
                                            }
                                        }
            
            GeometryReader { geometry in
                ForEach(items) { item in
                   
                    productItemGrid(products: items, total: items.count )
                    
                }
            }
            Spacer()
            
            
        }
    }
    private func updateFavorite(id: Int,isFavorite: Bool) {
        var position : Int = 0
        someVM.bindingValue.forEach { movie in
            if id == movie.id {
                let _: () = someVM.updateFavoriteId (id: id, isFavorite: true)
            }
            
            position+=1
                
        }
//        someVM.objectWillChange.send()
    }
    private func deleteItems(offsets: IndexSet) {
            withAnimation {
                for index in offsets {
                    modelContext.delete(items[index])
                    do {
                        try modelContext.save()
                    }catch {
                        print(error)
                    }
//                    updateFavorite(id: items[index].id, isFavorite: false)
                }
            }
        }
    func productItemGrid(products: [FavoriteSwiftData], total: Int) -> some View {
        GridStack(minCellWidth: screenWidth, spacing: 10, numItems: total,
                  alignment: .leading) {  index, cellWidth in
            
            FavoriteItemView(productModel: products[index],productModelPos: index)
            
            }
                .background(Rectangle().foregroundColor(Util.getColor("#fafafa")))
    }
}

//#Preview {
//    FavoriteView(hasNavigation: true)
//}
