//
//  ContentView.swift
//  MyMarkdown
//
//  Created by 孙瑞琦 on 2021/10/4.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: MyMarkdownDocument
    
    var body: some View {
        // 添加文本编辑器组件.
        Editor(document: $document)
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
