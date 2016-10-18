//
//  ScrollViewController.swift
//  LoginTest
//
//  Created by Rattee Wariyawutthiwat on 10/18/2559 BE.
//  Copyright © 2559 Rattee. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    @IBOutlet weak var loginButton:UIButton?
    @IBOutlet var textFields:Array<UITextField>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        
        if let scrollView = self.view as? UIScrollView {
            // This important!! make scrollView content offset size (then you can set its offset later)
            scrollView.contentSize = scrollView.frame.size
        }
        
        // tap Gesture for hide keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tapGesture)
    }
    
}

extension ScrollViewController {
    
    func hideKeyBoard() {
        // No matter which textfield is active. Resign it.
        textFields?.forEach{ textField in textField.resignFirstResponder() }
    }
    
    func keyboardWillShow(notification:NSNotification){
        print("keyboard will show")
        // content offset should calculate from login button position and keyboard's endframe
        let loginY = (loginButton?.frame.origin.y)! + (loginButton?.frame.size.height)!
        let userInfo = notification.userInfo
        let keyboardRect = (userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue()
        var diff = (keyboardRect?.origin.y)! - loginY
        if  diff < 0 {
            diff *= -1
            diff += 10 // adjust the gap between keyboard and login button
            if let scrollView = self.view as? UIScrollView {
                scrollView.setContentOffset(CGPoint(x: 0, y: diff), animated: false)
            }
        }
        
    }
    
    func keyboardWillHide(){
        print("keyboard will hide")
        if let scrollView = self.view as? UIScrollView {
            scrollView.setContentOffset(CGPointZero, animated: false)
        }
    }
    
}

