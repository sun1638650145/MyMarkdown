//
//  ContentView.swift
//  MyMarkdown
//
//  Created by 孙瑞琦 on 2021/10/4.
//

import SwiftUI
import Ink

struct ContentView: View {
    @Binding var document: MyMarkdownDocument
    var html: String {
        let _parser = MarkdownParser()
        return _parser.html(from: document.text)
    }
    
    var body: some View {
        HStack {
            // 添加文本编辑器组件.
            MarkdownEditor(document: $document)
            // 添加文本渲染器组件.
            MarkdownView(html: html)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // 配置iPad横屏模式.
        if #available(iOS 15, *) {
            ContentView(document: .constant(MyMarkdownDocument()))
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}
