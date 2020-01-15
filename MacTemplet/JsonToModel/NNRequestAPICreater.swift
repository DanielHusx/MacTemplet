//
//  NNRequestAPICreater.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/10.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NNRequestAPICreater: NSObject {

    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: type)
        return """
\(copyRight)
import UIKit

///
@objcMembers class \(name): IOPBaseAPIManager {
    
    @objc var name: String = ""
        
    @objc var dataModel: IOPDataModel = IOPDataModel()

    @objc var pageModel: IOPPageModel = IOPPageModel(perPageCounts: UInt(IOPDataConstansPageSize))

    override func requestURI() -> String {
        return ""
    }
    
    override func requestType() -> IOPAPIRequestType {
        return .post
    }
    
    override func reformerParams() -> [AnyHashable : Any] {
        let params: [AnyHashable : Any] = ["page" : pageModel.currPage,
                                           "page_item": pageModel.perPageCounts,
                                           "name": name,

        ]
        return params
    }
    
    override func validateParamsData() -> Bool {
//        if name.count < 4 {
//            IOPProgressHUD.showText("用户名必须大于等于4位")
//            return false;
//        }
        return true;
    }
}

/// 注册数据模型
@objcMembers class IOPDataModel: NSObject {
    @objc var name: String = ""
    @objc var password: String = ""
    @objc var phone: String = ""
    @objc var code: String = ""
    
}

"""
    }
}
