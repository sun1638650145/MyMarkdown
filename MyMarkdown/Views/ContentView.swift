//
//  ContentView.swift
//  MyMarkdown
//
//  Created by 孙瑞琦 on 2021/10/4.
//

import SwiftUI
import Ink

struct ContentView: View {
    @Binding var document: MarkdownDocument
    @State private var toolbarStatus = true /* 用于标记统计模式选项. */
    
    var html: String {
        let _parser = MarkdownParser()
        return _parser.html(from: document.text)
    }
    
    var body: some View {
        HStack {
            // 添加文本编辑器组件.
            MarkdownEditor(document: $document)
            Divider()
            // 添加文本渲染器组件.
            MarkdownView(html: html)
        }.toolbar {
            ToolbarItemGroup(placement: .navigation) {
                Button(action: { toolbarStatus = !toolbarStatus }) {
                    // 用于显示文本统计信息.
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
                Button(action: {
                    // 导出PDF文件.
                    fileExport(html: html)
                }) {
                    HStack {
                        Text("导出PDF")
                        Image(systemName: "arrow.down.circle.fill")
                    }
                    .foregroundColor(.blue)
                    .font(.system(size: 12))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // 配置iPad横屏模式.
        if #available(iOS 15, *) {
            ContentView(document: .constant(MarkdownDocument()))
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}
