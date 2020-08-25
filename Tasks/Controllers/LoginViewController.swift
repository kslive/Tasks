//
//  LoginViewController.swift
//  Tasks
//
//  Created by Eugene Kiselev on 25.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setObserver()
    }

    @IBAction func loginButton(_ sender: UIButton) {
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
    }
    
    // MARK: - Help Function
    
    func setObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func kbDidShow(notification: Notification) {
        
        guard let userInfo = notification.userInfo else { return }
        
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        scrollView.contentSize = CGSize(width: viewInSV.bounds.size.width, height: viewInSV.bounds.size.height + kbFrameSize.height)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc func kbDidHide() {
        
        scrollView.contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
}

