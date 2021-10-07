//
//  Editor.swift
//  MyMarkdown
//
//  Created by 孙瑞琦 on 2021/10/4.
//

import SwiftUI

struct Editor: View {
    @Binding var document: MyMarkdownDocument
    @State private var toolbarStatus = true /* 用于标记统计模式选项. */
    
    var body: some View {
        TextEditor(text: $document.text)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: { toolbarStatus = !toolbarStatus }) {
                        if toolbarStatus {
                            Text("\(document.text.count) 字符")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                        } else {
                            // 通过过滤换行符数量计算行数.
                            let lines = (document.text.filter() { $0 == "\n" }).count + 1
                            Text("\(lines) 行")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                        }
                    }
                }
            }
    }
}

struct Editor_Previews: PreviewProvider {
    static let doc = MyMarkdownDocument(text: "在此处输入Markdown源码.")
    // 预览文本编辑器.
    static var previews: some View {
        Editor(document: .constant(doc))
    }
}
