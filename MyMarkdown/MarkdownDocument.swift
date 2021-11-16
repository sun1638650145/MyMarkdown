//
//  MarkdownDocument.swift
//  MyMarkdown
//
//  Created by 孙瑞琦 on 2021/10/4.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    // 支持的导入文件类型.
    static let markdownDocument = UTType(importedAs: "com.sunruiqi.MyMarkdown.md")
}

struct MarkdownDocument: FileDocument {
    var text: String
    
    init(text: String = "# Hello, World!") {
        self.text = text
    }
    
    static var readableContentTypes: [UTType] { [.markdownDocument] }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
