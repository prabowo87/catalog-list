//
//  ToolbarView.swift
//  CatalogList
//
//  Created by Hermawan Prabowo on 06/03/24.
//

import SwiftUI
import SwiftData

struct ToolbarView: View {
    
    let iconSizeSearch : CGFloat = 24
        @State var hasNavigation : Bool
        
        
        var body: some View {
            
            HStack {
                Text("Product Catalog")
                    .font(.title)
                Spacer()
                
                    
                    NavigationLink(destination: FavoriteView()) {
                        Image("heart_filled")
                            .resizable()
                            .frame(width: iconSizeSearch, height: iconSizeSearch,alignment:.trailing)
                            .scaledToFit()
                        
                            
                    }
                
                
                
            }.padding(16)
        }
    }

    struct ToolbarView_Previews: PreviewProvider {
        static var previews: some View {
            Group{
                ToolbarView(hasNavigation: true)
                ToolbarView(hasNavigation: false)
            }.previewLayout(.fixed(width: 300, height: 56))
            
        }
    }

    extension View {
        
        //to make the icon size different for the filter icon
        func isFilter(_ hasNavigation: Bool)-> some View {
            if hasNavigation {
                
                return frame(width: 24, height: 22, alignment:.leading)
            }else{
                return frame(width: 24, height: 17, alignment:.leading)
            }
        }
        
    }

//#Preview {
//    ToolbarView(hasNavigation: true)
//}
