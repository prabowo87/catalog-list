//
//  LoaderView.swift
//  CatalogList
//
//  Created by Hermawan Prabowo on 06/03/24.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.05)
                .ignoresSafeArea()
            ProgressView()
                .scaleEffect(1, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
        }
    }
}

#Preview {
    LoaderView()
}
