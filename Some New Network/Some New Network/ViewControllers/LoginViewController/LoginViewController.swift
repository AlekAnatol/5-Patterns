//
//  LoginViewController.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 28.12.2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
//    private var session = Session.instance
//    private var handle: AuthStateDidChangeListenerHandle!

    
    let fromLoginToTabbarSegue = "fromLoginToTabbar"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.brandPink
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let recignizer = UITapGestureRecognizer(target: self, action: #selector(onTop))
        recignizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(recignizer)
        
    }
    
    @objc func onTop() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardDidHide() {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc func keyboardDidShow(_ notification: Notification ) {
        guard let keyBoardHeight = ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as?  NSValue)?.cgRectValue)?.height else {return}
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyBoardHeight - 10, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
      /*  guard let login = loginTextField.text,
              let password = passwordTextField.text,
              login.count > 0,
              password.count > 0 else {
                  let alert = UIAlertController(title: "Error",
                                                message: "Login or password is not entered",
                                                preferredStyle: .alert)
                  let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                  alert.addAction(actionOK)
                  self.present(alert, animated: true, completion: nil)
                  return
              }

        Auth.auth().signIn(withEmail: login, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Error",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(actionOK)
                self.present(alert, animated: true, completion: nil)

            } else {
                Session.instance.sessionUserRef = Session.instance.usersRef.child((user?.user.uid)!)
                self.performSegue(withIdentifier: self.fromLoginToTabbarSegue, sender: nil)
                self.loginTextField.text = nil
                self.passwordTextField.text = nil
            }
        }
       */
        self.performSegue(withIdentifier: self.fromLoginToTabbarSegue, sender: nil)
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {

        let alert = UIAlertController(title: "Register",
                                      message: "",
                                      preferredStyle: .alert)
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            
            guard let emailField = alert.textFields?[0],
                  let passwordField = alert.textFields?[1],
                  let password = passwordField.text,
                  let email = emailField.text else { return }
            
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
                if let error = error {
                    let errorAlert = UIAlertController(title: "Error",
                                                       message: error.localizedDescription,
                                                       preferredStyle: .alert)
                    let actionReturn = UIAlertAction(title: "OK", style: .cancel, handler:  nil)
                    errorAlert.addAction(actionReturn)
                    guard let self = self else { return }
                    self.present(errorAlert, animated: true, completion: nil)
                } else {
                    Auth.auth().signIn(withEmail: email, password: password)
                }
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
