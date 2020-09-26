//
//  ProgressView.swift
//  Movie DB
//
//  Created by Myo Zaw Oo on 26/09/2020.
//

import SwiftUI

struct ProgressView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
            
    }
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.startAnimating()
    }
}
