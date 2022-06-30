//
//  GIFImage.swift
//  FreshWorks
//
//  Created by AftabAhmed on 29/06/22.
//

import SwiftUI
import WebKit

/// This is a UIView representable struct to embed WKWebView
struct GIFImage: UIViewRepresentable {
    
    private var data: Data
    
    init(_ dat: Data) {
        self.data = dat
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: NSURL() as URL
        )
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
    }
}
