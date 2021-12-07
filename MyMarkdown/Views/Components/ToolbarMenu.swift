//
//  ToolbarMenu.swift
//  MyMarkdown
//
//  Created by 孙瑞琦 on 2021/12/6.
//

import SwiftUI

struct ToolbarMenu: View {
    var html: String
    @EnvironmentObject var status: EnvStatus
    
    var body: some View {
        Menu {
            Button(action: {
                // 改变预览模式.
                status.fullScreenPreview = !status.fullScreenPreview
            }) {
                if status.fullScreenPreview {
                    Text("\(NSLocalizedString("editMode", comment: "Edit mode."))")
                } else {
                    Text("\(NSLocalizedString("fullScreenPreviewMode", comment: "Full screen preview mode."))")
                }
            }
            Button(action: {
                // 导出PDF文件.
                fileExport(html: html)
            }) {
                HStack {
                    Text("\(NSLocalizedString("exportPDF", comment: "Export PDF file."))")
                    Image(systemName: "arrow.down.circle")
                }
                .foregroundColor(.blue)
                .font(.system(size: 12))
            }
        } label: {
            Image(systemName: "ellipsis.circle.fill")
                .font(.system(size: 12))
        }
    }
}

struct ToolbarMenu_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarMenu(html: "<h1>Hello, World!</h1>")
            .environmentObject(EnvStatus())
    }
}
