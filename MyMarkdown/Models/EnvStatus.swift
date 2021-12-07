//
//  EnvStatus.swift
//  MyMarkdown
//
//  Created by 孙瑞琦 on 2021/12/7.
//

import Combine

/* 记录环境状态信息. */
class EnvStatus: ObservableObject {
    @Published var fullScreenPreview: Bool = false /* 是否全屏预览. */
    @Published var recordMode: Int = 0 /* 用于记录统计模式选项(0.字符数 1.行数). */
}
