//
//  ViewController.swift
//  WXPasteImage
//
//  Created by FZHONGLI on 16/3/17.
//  Copyright © 2016年 FZHONGLI. All rights reserved.
//

import UIKit
//返回值是一个函数指针，入参为String 返回值也是String
typealias funcBlockC = (Int,Int) -> (String)->String

class ViewController: UIViewController {
    
    var pasteImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pasteboard = UIPasteboard.generalPasteboard()
        
        if pasteboard.image != nil {
            let menuController = UIMenuController.sharedMenuController()
            let pasteMenuItem = UIMenuItem.init(title: "粘贴", action: "pasteImage")
            menuController.menuItems = [pasteMenuItem]
            menuController.menuVisible = true
        }
        
        testBlockC({
            (a:Int,b:Int) -> (String)->String in
            func sumrsult(res:String) -> String
            {
                let c = a*a+b*a
                return "\(res) \(a)*\(a)+\(b)*\(a) = \(c)"
            }
            return sumrsult
        })
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == "pasteImage" {
            return true
        }
        return false
    }
    
    func testBlockC(blockfunc:funcBlockC?) {
        if let exsistblock = blockfunc {
            let retfunc = exsistblock(5,6)
            let str = retfunc("最终果结是")
            print(str)
        }
    }
    
    func pasteImage() {
        
        func showPasteImage() {
            let pasteboard = UIPasteboard.generalPasteboard()
            self.pasteImageView = UIImageView.init(image: pasteboard.image)
            
            UIApplication.sharedApplication().keyWindow?.addSubview(self.pasteImageView)
            self.pasteImageView.center = self.view.center
            self.pasteImageView.bounds = CGRectMake(0, 0, self.view.frame.size.width-30, (self.view.frame.size.width-30)*(pasteboard.image?.size.height)!/(pasteboard.image?.size.width)!)
            self.pasteImageView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height)
            
            UIView.animateWithDuration(1, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
                self.pasteImageView.transform = CGAffineTransformMakeTranslation(0, 0)
                }, completion: nil)
            
            self.pasteImageView.userInteractionEnabled = true
            self.pasteImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: "tapImage"))
        }
        
        if pasteImageView != nil {
            
            
            tapImage({ (finished) -> Void in
                
                showPasteImage()
                
            })
        }else {
            showPasteImage()
        }
        
        
        
        self.view.endEditing(true)
    }
    
    func tapImage() {
        tapImage(nil)
    }
    
    func tapImage(completion: ((Bool) -> Void)?) {
        
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .CurveEaseInOut, animations: { () -> Void in
            self.pasteImageView.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height)
            self.pasteImageView.alpha = 0.0
            }) { finished -> Void in
                self.pasteImageView.removeFromSuperview()
                completion?(true)
                
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

