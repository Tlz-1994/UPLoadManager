//
//  Upload.swift
//  CountApp
//
//  Created by stefanie on 16/6/27.
//  Copyright © 2016年 Stefanie. All rights reserved.
//

import UIKit
import Qiniu

import ReactiveCocoa

class Upload: NSObject {
    
    var str: String {
        get {
            return self.str
        }
        set {
            self.str = "i love"
        }
    }
    
    static func uploadFile(filePath: String) {
        let manager = QNUploadManager()
        manager.putFile(filePath, key: filePath, token: "", complete: { (info, fileURL, object) in
            
            }, option: nil)
        
        let textfield = UITextField.init(frame: CGRectMake(0, 0, 100, 100))
        textfield.backgroundColor = UIColor.redColor()
        
        
    }
    
    
    
    
    
}
