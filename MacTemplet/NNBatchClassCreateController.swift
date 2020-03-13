//
//  NNBatchClassCreateController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/13.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand
import SnapKit
import SnapKitExtend

class NNBatchClassCreateController: NSViewController {
    
    lazy var textView: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 12)
        view.string = ""
        view.delegate = self
        return view;
    }()
    
    lazy var segmentCtl: NSSegmentedControl = {
        let view = NSSegmentedControl(frame: .zero)
        view.items = ["UIViewController文件", "自定义UIView文件", "API文件", "ViewModel文件",]

        return view;
    }()

    lazy var btnPop: NSPopUpButton = {
        let view = NSPopUpButton(frame: .zero, pullsDown: false)
        view.autoenablesItems = false
        
        let list = ["Swift", "ObjC",]
        view.addItems(withTitles: list)
        view.addActionHandler { (control) in
            NSApp.mainWindow?.makeFirstResponder(nil)
//            let sender: NSPopUpButton = control as! NSPopUpButton;
//            DDLog(sender.titleOfSelectedItem)
            self.batchCreateFile(self.textView.string)

        }
        return view;
    }()

    lazy var btn: NSButton = {
        let view = NSButton(title: "Done", target: nil, action: nil)
        view.setButtonType(.momentaryPushIn)
        view.bezelStyle = .rounded
//        view.bezelColor = NSColor.blue.withAlphaComponent(0.5)
        view.addActionHandler { (control) in
            NSApp.mainWindow?.makeFirstResponder(nil)
            self.batchCreateFile(self.textView.string)

        }
        return view;
    }()
    
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        title = "iOS类文件批量生成"
        view.addSubview(btn)
        view.addSubview(btnPop)
        view.addSubview(segmentCtl)
        view.addSubview(textView.enclosingScrollView!)
        
//        view.getViewLayer()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
                
        btn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        btnPop.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.right.equalTo(btn.snp.left).offset(-10)
            make.height.equalTo(btn)
            make.width.equalTo(btn)
        }
        
        let width = CGFloat(segmentCtl.items.count)*120
        segmentCtl.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(width)
        }
        
        textView.enclosingScrollView!.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalTo(btn.snp.top).offset(-10)
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
    
    // MARK: -funcitons
    /// 批量创建文件
    func batchCreateFile(_ string: String) {
        if string.count <= 0 {
            return
        }
        createFiles(string, idx: segmentCtl.selectedSegment, type: btnPop.titleOfSelectedItem!.lowercased())
    }
    /// 按照类型创建文件
    func createFiles(_ string: String, idx: Int, type: String = "swift") {
        if string.count <= 0 {
            return
        }
        
        let separate = string.contains(";") ? ";" : "\n"
        let titles = string.components(separatedBy: separate)
        var result = ""

        for e in titles.enumerated() {
            if e.element == "" {
                continue;
            }
            var name = e.element.trimmingCharacters(in: .whitespaces)
            name = name.trimmingCharacters(in: CharacterSet(charactersIn: "\n"))
            
            switch idx {
            case 1: // 创建自定义视图
                if !name.hasSuffix("View") {
                    _ = NSAlert.show("错误", msg: "自定义视图必须包含 View 后缀", btnTitles: [kTitleSure], window: NSApp.keyWindow!)
                    return
                }
                NNBatchManager.createUIViewFiles(name, type: type)
                
            case 2: // 创建 API 类
                if !name.lowercased().hasSuffix("api") {
                    _ = NSAlert.show("错误", msg: "必须包含 API/Api 后缀", btnTitles: [kTitleSure], window: NSApp.keyWindow!)
                    return
                }
                NNBatchManager.createAPIFiles(name, type: type)

            case 3: //
                if !name.hasSuffix("ViewModel") {
                    _ = NSAlert.show("错误", msg: "RequestViewModel文件必须包含 ViewModel 后缀", btnTitles: [kTitleSure], window: NSApp.keyWindow!)
                    return
                }
                NNBatchManager.createViewModelFiles(name, type: type)
                
            default: // 创建 UIViewController 文件
                if !name.hasSuffix("Controller") {
                    _ = NSAlert.show("错误", msg: "页面必须包含 Controller 后缀", btnTitles: [kTitleSure], window: NSApp.keyWindow!)
                    return
                }
                NNBatchManager.createControllerFiles(name, type: type)
            }
        }
    }
    
}

extension NNBatchClassCreateController: NSTextViewDelegate {

    func textShouldBeginEditing(_ textObject: NSText) -> Bool{
        return true
    }

    func textShouldEndEditing(_ textObject: NSText) -> Bool {
        return true
    }
    
    func textDidBeginEditing(_ notification: Notification){
        
    }

    func textDidEndEditing(_ notification: Notification){
        
    }

    func textDidChange(_ notification: Notification) {
        batchCreateFile(textView.string)
    }
}
