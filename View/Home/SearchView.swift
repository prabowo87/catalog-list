//
//  SearchView.swift
//  CatalogList
//
//  Created by Hermawan Prabowo on 06/03/24.
//

import SwiftUI

struct SearchView: View {
    let width = UIScreen.main.bounds.width - 32
//        @State private var searchText = SearchTextChangeObservable()
//        var searchChangeDelegate : SearchChangeDelegate?
    @State private var name = ""
    var body: some View {
        ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.fromHex(Constants.COLOR_GREY_400), lineWidth: 1)
                        .frame(width: width, height: 48, alignment: .center)
                    
                    HStack {
                        TextField("Search here", text: $name).padding()
                                 
                        Image("search")
                            .resizable()
                            .frame(width:18, height:18)
                            .scaledToFit()
                        Spacer()
                        Spacer()
                    }
                }
        .padding(.horizontal)
    }
}

#Preview {
    SearchView()
}
