//
//  ViewController.swift
//  LoginTest
//
//  Created by Rattee Wariyawutthiwat on 10/18/2559 BE.
//  Copyright © 2559 Rattee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var pickerTextField:UITextField?
    @IBOutlet var textFields:Array<UITextField>?
    let pickerTitle = ["Pikachu","Chamander","Squirtle"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tapGesture)
        
        // set pickerview instead of usual keyboard
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerTextField?.inputView = pickerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == pickerTextField {
            return false
        }
        return true
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerTitle.count
    }
}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerTitle[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Set textfield text to selected item
        self.pickerTextField?.text = pickerTitle[row]
    }
}

extension ViewController {
    
    func hideKeyBoard() {
        print("keyboard should hide")
        textFields?.forEach{ textField in textField.resignFirstResponder() }
    }
    
    func keyboardWillShow(){
        print("keyboard will show")
    }
    
    func keyboardWillHide(){
        print("keyboard will hide")
    }
    
}

