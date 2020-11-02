//
//  ActivityIndicatorView.swift
//  MultiCurrencyShop
//
//  Created by Viraj Padia on 07/07/2020.
//  Copyright © 2020 Viraj Padia. All rights reserved.
//

import SwiftUI
struct ActivityIndicatorView: UIViewRepresentable{
    var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
