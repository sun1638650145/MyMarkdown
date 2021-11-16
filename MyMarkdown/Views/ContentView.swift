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
            // 添加文本渲染器组件.
            MarkdownView(html: html)
        }.toolbar {
            ToolbarItemGroup(placement: .navigation) {
                // 用于显示文本统计信息.
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
                // 导出PDF文件.
                Button(action: {
                    // 创建html格式化打印.
                    let markupText = UIMarkupTextPrintFormatter(markupText: html)
                    // 绘制要打印内容页面的渲染器.
                    let render = UIPrintPageRenderer()
                    /* A4: 210 x 297mm (8-1/4 x 11-3/4 in) 在72dpi时, 像素值为595.3, 841.9 */
                    let pageRect = CGRect(x: 0.0, y: 0.0, width: 595.3, height: 841.9)
                    /* Pages文稿 文稿页边空白 顶部32.5mm 底部35mm 左边20mm 右边20mm */
                    let printableRect = CGRect(x: 56.7, y: 92.1, width: 481.9, height: 650.6)
                    
                    // 从第0页开始向渲染器添加内容, 纸张大小, 打印区域大小.
                    render.addPrintFormatter(markupText, startingAtPageAt: 0)
                    render.setValue(pageRect, forKey: "paperRect")
                    render.setValue(printableRect, forKey: "printableRect")
                    
                    // 链接到动态字节缓冲区.
                    let pdfData = NSMutableData()
                    // 创建PDF上下文.
                    UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
                    
                    for i in 0..<render.numberOfPages {
                        UIGraphicsBeginPDFPage() /* 创建新的PDF页面. */
                        render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds()) /* 绘制PDF页面. */
                    }
                    // 关闭PDF上下文.
                    UIGraphicsEndPDFContext()
                    
                    // 保存PDF文件.
                    // TODO: 1. 提示保存成功 2. 实现自定义文件名
                    let filePath:String = NSHomeDirectory() + "/Documents/export.pdf"
                    pdfData.write(toFile: filePath, atomically: true)
                    
                    print("导出成功.")
                    print(filePath)
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
