//
//  FileExport.swift
//  MyMarkdown
//
//  Created by 孙瑞琦 on 2021/11/18.
//

import OSLog
import SwiftUI

func fileExport(html: String) {
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
    
    os_log("导出成功.", type: .info)
    os_log("%@", type: .info, filePath)
}
