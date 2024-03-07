//
//  ToolbarView.swift
//  CatalogList
//
//  Created by Hermawan Prabowo on 07/03/24.
//

import SwiftUI

struct ToolbarFavoriteView: View {
    let iconSizeSearch : CGFloat = 24
        @State var hasNavigation : Bool
        @Environment(\.presentationMode) var mode: Binding<PresentationMode>
        
        var body: some View {
            
            HStack {
                Text("Favorite")
                    .font(.title)
                Spacer()
                
                
                
            }.padding(16)
        }
}


#Preview {
    ToolbarFavoriteView(hasNavigation: true)
}
