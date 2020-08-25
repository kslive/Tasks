//
//  LoginViewController.swift
//  Tasks
//
//  Created by Eugene Kiselev on 25.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let segueIdentifier = "tasksSegue"

    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        warningLabel.alpha = 0
        setObserver()
        setUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }

    @IBAction func loginButton(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            
            displayWarningLabel(withText: "Error404.123")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            
            if error != nil {
                self?.displayWarningLabel(withText: "Error ocurred")
                return
            }
            
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueIdentifier)!, sender: nil)
                return
            }
            
            self?.displayWarningLabel(withText: "No such User")
        }
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            
            displayWarningLabel(withText: "Error404.123")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
    
            if error == nil {
                if user != nil {
                } else {
                    print("error")
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    // MARK: - Help Function
    
    func setUser() {
        
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueIdentifier)!, sender: nil)
            }
        }
    }
    
    func displayWarningLabel(withText text: String) {
        
        warningLabel.text = text
        
        UIView.animate(withDuration: 3,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
                        self?.warningLabel.alpha = 1
        }) { [weak self]complete in
            self?.warningLabel.alpha = 0 }
    }
    
    func setObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func kbDidShow(notification: Notification) {
        
        guard let userInfo = notification.userInfo else { return }
        
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height + kbFrameSize.height)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc func kbDidHide() {
        
        scrollView.contentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height)
    }
}

