//
//  MarkdownEditor.swift
//  MyMarkdown
//
//  Created by 孙瑞琦 on 2021/10/4.
//

import SwiftUI
import SwiftDown

struct MarkdownEditor: View {
    @Binding var document: MyMarkdownDocument
    
    var body: some View {
        // 添加对Markdown文本的渲染.
        SwiftDownEditor(text: $document.text)
            .theme(Theme.BuiltIn.defaultLight.theme())
    }
}

struct Editor_Previews: PreviewProvider {
    static let doc = MyMarkdownDocument(text: "在此处输入Markdown源码.")
    // 预览文本编辑器.
    static var previews: some View {
        MarkdownEditor(document: .constant(doc))
    }
}
