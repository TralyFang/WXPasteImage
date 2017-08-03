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
        
        let pasteboard = UIPasteboard.general
        
        if pasteboard.image != nil {
            let menuController = UIMenuController.shared
            let pasteMenuItem = UIMenuItem.init(title: "粘贴", action: #selector(ViewController.pasteImage))
            menuController.menuItems = [pasteMenuItem]
            menuController.isMenuVisible = true
        }
        
        testBlockC({
            (a:Int,b:Int) -> (String)->String in
            func sumrsult(_ res:String) -> String
            {
                let c = a*a+b*a
                return "\(res) \(a)*\(a)+\(b)*\(a) = \(c)"
            }
            return sumrsult
        })
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(ViewController.pasteImage) {
            return true
        }
        return false
    }
    
    func testBlockC(_ blockfunc:funcBlockC?) {
        if let exsistblock = blockfunc {
            let retfunc = exsistblock(5,6)
            let str = retfunc("最终果结是")
            print(str)
        }
    }
    
    func pasteImage() {
        
        func showPasteImage() {
            let pasteboard = UIPasteboard.general
            self.pasteImageView = UIImageView.init(image: pasteboard.image)
            
            UIApplication.shared.keyWindow?.addSubview(self.pasteImageView)
            self.pasteImageView.center = self.view.center
            self.pasteImageView.bounds = CGRect(x: 0, y: 0, width: self.view.frame.size.width-30, height: (self.view.frame.size.width-30)*(pasteboard.image?.size.height)!/(pasteboard.image?.size.width)!)
            self.pasteImageView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
            
            UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(), animations: { () -> Void in
                self.pasteImageView.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            
            self.pasteImageView.isUserInteractionEnabled = true
            self.pasteImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(ViewController.tapImage as (ViewController) -> () -> ())))
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
    
    func tapImage(_ completion: ((Bool) -> Void)?) {
        
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.pasteImageView.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
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

