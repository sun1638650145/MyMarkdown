//
//  MyMarkdownApp.swift
//  MyMarkdown
//
//  Created by 孙瑞琦 on 2021/10/4.
//

import SwiftUI

@main
struct MyMarkdownApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: MarkdownDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
