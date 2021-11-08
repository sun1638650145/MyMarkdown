//
//  MarkdownView.swift
//  MyMarkdown
//
//  Created by 孙瑞琦 on 2021/11/8.
//

import SwiftUI
import WebKit

struct MarkdownView: UIViewRepresentable {
    var html: String
    
    init(html: String) {
        self.html = html
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(html, baseURL: nil)
    }
}
