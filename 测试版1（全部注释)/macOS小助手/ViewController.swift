//
//  ViewController.swift
//  macOS小助手
//
//  Created by mac on 2023/1/1.
//  由mac于2023/1/1创建。
//
//  判断：链接StoryBoard视图和代码——庞玺桐2023.1.1
//  指南：在Xcode 14.2打开此文件后，按住option后在左侧菜单栏点按Main.storyboard，按住control后拖拽元素到此文件创建函数，在函数中写入Main.storyboard中元素在执行时运行的swift代码

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 加载视图后执行任何其他设置。
        // Do any additional setup after loading the view.
    }

    ;    override var representedObject: Any? {
        didSet {
        // 更新视图（如果已加载）。
        // Update the view, if already loaded.
        }
    }


}

