//
//  ProductImageView.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//
import SwiftUI

struct ProductImageView: View {
    @ObservedObject var imageViewModel: ImageViewModel
    
    init(urlString: String?) {
        imageViewModel = ImageViewModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: imageViewModel.image ?? ProductImageView.defaultImage!)
            .resizable()
            .scaledToFit()
            .frame(width: 75, height: 75)
    }
    
    static var defaultImage = UIImage(systemName: "questionmark.circle.fill")
}
