//
//  LoginVC.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation
import UIKit

class LoginVC : EXViewController {
    
    
    // MARK: - View
    private lazy var bgTap : UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        return tap
    }()
    @objc private func backgroundTapped(){
        self.view.endEditing(true)
    }
    
    private lazy var appTitle : UILabel = {
        
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .black
        v.text = Str.app_name
        v.font = .bold40
        
        return v
    }()
    
    private lazy var emailLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .black
        v.text = Str.common_email
        v.font = .bold20
        return v
    }()
    
    private lazy var passwordLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .black
        v.text = Str.common_password
        v.font = .bold20
        return v
    }()
    
    private lazy var emailTextField : CommonTextField = {
        let v = CommonTextField()
        v.keyboardType = .emailAddress
        v.enablesReturnKeyAutomatically = true
        v.returnKeyType = .continue
        v.text = AppModel.shared.lastLoginnedEmail
        return v
    }()
    
    private lazy var passwordTextField : CommonTextField = {
        let v = CommonTextField()
        v.enablesReturnKeyAutomatically = true
        v.isSecureTextEntry = true
        v.returnKeyType = .done
        return v
    }()
    
    private lazy var emailErrorLabel: ErrorLabel = {
        let v = ErrorLabel()
        return v
    }()
    
    private lazy var passwordErrorLabel: ErrorLabel = {
        let v = ErrorLabel()
        return v
    }()
    
    private lazy var submitButton : RoundButton = {
        let v = RoundButton(heightType: .Height36)
        v.text = Str.common_login
        v.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return v
    }()
    
}

// MARK: - Function
extension LoginVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCustomNavigationBar()
        title = Str.common_login
        view.backgroundColor = .white
        
        initView()
    }
    
    private func initView(){
        view.addGestureRecognizer(bgTap)
        
        view.addSubviews(emailLabel, emailTextField,emailErrorLabel, passwordLabel, passwordTextField,passwordErrorLabel, submitButton, appTitle)
        
        let views = [
            "appTitle" : appTitle,
            "emailLabel": emailLabel,
            "emailTextField" : emailTextField,
            "passwordLabel" : passwordLabel,
            "passwordTextField" : passwordTextField,
            "submitButton" : submitButton,
            "emailErrorLabel" : emailErrorLabel,
            "passwordErrorLabel" : passwordErrorLabel
        ]

        view.addConstraints("H:[appTitle]",  options: .alignAllCenterX, views :views)
        view.addConstraints("|-24-[emailLabel]-24-|", views: views)
        view.addConstraints("|-16-[emailTextField]-16-|", views: views)
        view.addConstraints("|-16-[emailErrorLabel]-16-|", views: views)
        view.addConstraints("|-24-[passwordLabel]-24-|", views: views)
        view.addConstraints("|-16-[passwordTextField]-16-|", views: views)
        view.addConstraints("|-16-[passwordErrorLabel]-16-|", views: views)
        view.addConstraints("[submitButton]-16-|", views: views)
        
        emailLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16).isActive = true
        
        view.addConstraints("V:[appTitle]-[emailLabel]-[emailTextField]-[emailErrorLabel]-32-[passwordLabel]-[passwordTextField]-[passwordErrorLabel]-16-[submitButton]", views: views)
    }
    
    @objc func submitButtonTapped() {
        view.endEditing(true)
        
        clearErrorMessages()
        
        /// Email Empty
        guard let email = emailTextField.text, emailTextField.text?.isEmpty == false else{
            showEmailErrorMessage(message: Str.error_email_empty)
            return
        }
        
        /// Email Regex fail
        guard emailTextField.text?.isValidEmail == true else {
            showEmailErrorMessage(message: Str.error_email_regex_invalid)
            return
        }
        
        /// Password Empty
        guard let password = passwordTextField.text, passwordTextField.text?.isEmpty == false else{
            showPasswordErrorMessage(message: Str.error_password_empty)
            return
        }
        
        /// Password Regex fail
        guard passwordTextField.text?.isValidPassword == true else {
            showPasswordErrorMessage(message: Str.error_password_regex_invalid)
            return
        }
        
        showProgress()
        
        User.signIn(withEmail: email, password: password,acceptedLegalNoticeVersion: nil).done { user in
            self.dismiss(animated: true, completion: nil)
        }.catch {[unowned self] e in
            
            switch e.errorCode{
 
                case .userNotFound:
                    self.showEmailErrorMessage(message: e.errorCode!.localizedDescription)
                    break
                case .passwordInvalid:
                    self.showPasswordErrorMessage(message: e.errorCode!.localizedDescription)
                    break
                default:
//                    CommonDialog.show(error: e)
                break
            }
        }.finally {
            self.hideProgress()
        }
    }
    
    
    private func showEmailErrorMessage(message: String?){
        clearErrorMessages()
        emailErrorLabel.text = message
        emailErrorLabel.startShakeAnimation()
    }
    private func showPasswordErrorMessage(message: String?){
        clearErrorMessages()
        passwordErrorLabel.text = message
        passwordTextField.startShakeAnimation()
    }
    
    private func clearErrorMessages(){
        emailErrorLabel.text = ""
        passwordErrorLabel.text = ""
    }
}
