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
//        增加选项卡显示统计模式.
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Text("\(document.text.count) 字符")
                        .foregroundColor(.gray)
                }
                ToolbarItem(placement: .navigation) {
//                    使用换行符数量计算行数.
                    let lines = (document.text.filter() {$0 == "\n"}).count + 1
                    Text("\(lines) 行")
                        .foregroundColor(.gray)
                }
            }
    }
}

struct Editor_Previews: PreviewProvider {
    static let doc = MyMarkdownDocument(text: "在此处输入Markdown源码.")
//    预览文本编辑器.
    static var previews: some View {
        Editor(document: .constant(doc))
    }
}
