//
//  Editor.swift
//  MyMarkdown
//
//  Created by 孙瑞琦 on 2021/10/4.
//

import SwiftUI

struct Editor: View {
    @Binding var document: MyMarkdownDocument
    
    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct Editor_Previews: PreviewProvider {
    static let doc = MyMarkdownDocument(text: "在此处输入Markdown源码.")
//    预览文本编辑器.
    static var previews: some View {
        Editor(document: .constant(doc))
    }
}
