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
    @EnvironmentObject var status: EnvStatus
    
    var html: String {
        let _parser = MarkdownParser()
        return _parser.html(from: document.text)
    }
    
    var body: some View {
        HStack {
            if status.fullScreenPreview {
                // 只添加文本渲染器组件.
                MarkdownView(html: html)
            } else {
                // 添加文本编辑器和文本渲染器组件.
                MarkdownEditor(document: $document)
                Divider()
                MarkdownView(html: html)
            }
        }.toolbar {
            ToolbarItemGroup(placement: .navigation) {
                Button(action: {
                    status.recordMode = (status.recordMode + 1) % 2
                }) {
                    // 用于显示文本统计信息.
                    if status.recordMode == 0 {
                        Text("\(document.text.count) " +
                             "\(NSLocalizedString("character", comment: "Number of characters in the file."))")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                    } else if status.recordMode == 1 {
                        // 通过过滤换行符数量计算行数.
                        let lines = (document.text.filter() { $0 == "\n" }).count + 1
                        Text("\(lines) " +
                             "\(NSLocalizedString("line", comment: "Number of lines in the file."))")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                    }
                }
                // 添加工具栏菜单组件.
                ToolbarMenu(html: html).environmentObject(status)
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
                .environmentObject(EnvStatus())
        }
    }
}
