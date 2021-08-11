//
//  LoginVC.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation
import UIKit
import AuthenticationServices
import NaverThirdPartyLogin
import Alamofire

class LoginVC : EXViewController {
    
    @objc var naverTapHandler :( () -> Void)?
    @objc var kakaoTapHandler :( () -> Void)?
    @objc var appleTapHandler :( () -> Void)?
    @objc var closeTapHandler :( () -> Void)?
    
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    
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
    
    
    
    private lazy var naverLoginButton : RoundButton = {
        let v = RoundButton(heightType: .Height54)
        v.text = Str.common_naver_login
        v.backgroundColor = .naverGreen
        v.rippleColor = .naverGreen
        v.layer.cornerRadius = 10
        v.addTarget(self, action: #selector(naverLoginTapped), for: .touchUpInside)
        return v
    }()
    
    private lazy var kakaoLoginButton : RoundButton = {
        let v = RoundButton(heightType: .Height54)
        v.text = Str.common_kakao_login
        v.backgroundColor = .kakaoYellow
        v.setTitleColor(.black, for: .normal)
        v.rippleColor = .kakaoYellow
        v.layer.cornerRadius = 10
        v.addTarget(self, action: #selector(kakaoLoginTapped(_:)), for: .touchUpInside)
        return v
    }()
    
    private lazy var appleLoginButton : RoundButton = {
        let v = RoundButton(heightType: .Height54)
        v.text = Str.common_apple_login
        v.backgroundColor = .black
        v.layer.cornerRadius = 10
        v.addTarget(self, action: #selector(appleLoginTapped(_:)), for: .touchUpInside)
        return v
    }()
    
//    @available(iOS 13.0,*)
//    private lazy var appleFakeButton: ASAuthorizationAppleIDButton = {
//        let v = ASAuthorizationAppleIDButton()
//        v.isHidden = true
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
//        return v
//    }()
    
    private var naverLogo : UIImageView = {
        let v = UIImageView(named:"naver_no_bg")
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 50).isActive = true
        v.heightAnchor.constraint(equalToConstant: 50).isActive = true
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    private var kakaoLogo : UIImageView = {
        let v = UIImageView(named:"kakao_no_bg")
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 50).isActive = true
        v.heightAnchor.constraint(equalToConstant: 50).isActive = true
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    private var appleLogo : UIImageView = {
        let v = UIImageView(named:"iconLoginApple")
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 50).isActive = true
        v.heightAnchor.constraint(equalToConstant: 50).isActive = true
        v.contentMode = .scaleAspectFit
        v.image = v.image!.withRenderingMode(.alwaysTemplate)
        v.tintColor = .white
        return v
    }()
    
    private lazy var closeButton : UIImageView = {
        
        let v = UIImageView(named:"close")
        
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(closeTapGesture)
        v.image = v.image!.withRenderingMode(.alwaysTemplate)
        v.tintColor = .black
        
        return v
    }()
    
    private lazy var closeTapGesture : UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeTapped(_:)))
        return tap
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
        initHandler()
    }
    private func initHandler() {
        
        naverTapHandler = { [unowned self] in
            self.naverLogin()
        }
        kakaoTapHandler = { [unowned self ] in
            self.kakaoLogin()
        }
        appleTapHandler = { [unowned self ] in
            self.appleLogin()
        }
        
        closeTapHandler = { [unowned self] in
            debugE("가즈아")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func initView(){
        view.addGestureRecognizer(bgTap)
        
        view.addSubviews(appTitle, naverLoginButton, kakaoLoginButton, appleLoginButton, naverLogo, kakaoLogo, appleLogo, closeButton )
        
        let views = [
            "appTitle" : appTitle,
            "naverLoginButton" : naverLoginButton,
            "kakaoLoginButton" : kakaoLoginButton,
            "appleLoginButton" : appleLoginButton,
            "naverLogo" : naverLogo,
            "kakaoLogo" : kakaoLogo,
            "appleLogo" : appleLogo,
            "closeButton" : closeButton

        ]

        appTitle.activateCenterXConstraint(to: view)
        
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16).isActive = true
        
        view.addConstraints("V:|-100-[appTitle]-20-[naverLoginButton]-15-[kakaoLoginButton]-15-[appleLoginButton]", views: views)
        view.addConstraints("H:|-24-[naverLoginButton]-24-|", views : views )
        view.addConstraints("H:|-24-[kakaoLoginButton]-24-|", views : views )
        view.addConstraints("H:|-24-[appleLoginButton]-24-|", views : views )
        view.addConstraints("H:[closeButton]-24-|", views : views)
        
        naverLogo.topAnchor.constraint(equalTo: naverLoginButton.topAnchor).isActive = true
        naverLogo.bottomAnchor.constraint(equalTo: naverLoginButton.bottomAnchor).isActive = true
        naverLogo.leftAnchor.constraint(equalTo: naverLoginButton.leftAnchor).isActive = true
        
        kakaoLogo.topAnchor.constraint(equalTo: kakaoLoginButton.topAnchor).isActive = true
        kakaoLogo.bottomAnchor.constraint(equalTo: kakaoLoginButton.bottomAnchor).isActive = true
        kakaoLogo.leftAnchor.constraint(equalTo: kakaoLoginButton.leftAnchor).isActive = true
        
        appleLogo.topAnchor.constraint(equalTo: appleLoginButton.topAnchor).isActive = true
        appleLogo.bottomAnchor.constraint(equalTo: appleLoginButton.bottomAnchor).isActive = true
        appleLogo.leftAnchor.constraint(equalTo: appleLoginButton.leftAnchor).isActive = true
        
        appTitle.topAnchor.constraint(equalTo: closeButton.topAnchor, constant: 100).isActive = true
    }
    
    @objc func naverLoginTapped(_ sender : UITapGestureRecognizer){
        naverTapHandler?()
    }
    @objc func kakaoLoginTapped (_ sender :UITapGestureRecognizer) {
        kakaoTapHandler?()
    }
    
    @objc func appleLoginTapped (_ sender : UITapGestureRecognizer ){
        appleTapHandler?()
    }
    
    
    @objc func closeTapped (_ sender : UITapGestureRecognizer ){
        closeTapHandler?()
    }
    
    private func getNaverInfo() {
        
        debugE("GOOD")
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken {
          return
        }
        
        debugE("GOOD!")
        
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!
        
        debugE("ASDF")
        debugE(accessToken)
        let authorization = "Bearer \(accessToken)"
        
        let req = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        req.responseJSON { response in
            
            debugE(response)
          guard let result = response.result.value as? [String: Any] else { return }
          guard let object = result["response"] as? [String: Any] else { return }
          guard let profileImage = object["profile_image"] as? String else { return }
          guard let nickname = object["name"] as? String else { return }
          
//          self.nameLabel.text = "\(name)"
//          self.emailLabel.text = "\(email)"
//          self.nicknameLabel.text = "\(nickname)"
            
            debugE(nickname)
            debugE(profileImage)
        }
      }
    
    
    private func naverLogin() {
        debugE("NAVER LOGIN")
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    
    private func kakaoLogin() {
        loginInstance?.requestDeleteToken()
    }
    
    private func appleLogin () {
        
        
    }
    
    
}



//
//// MARK: - Apple Login
//extension LoginVC: ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding {
//    @available(iOS 13.0, *)
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return self.view.window!
//    }
//    @available(iOS 13.0, *)
//    @objc func handleAuthorizationAppleIDButtonPress() {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let appleIDRequest = appleIDProvider.createRequest()
//        appleIDRequest.requestedScopes = [.fullName, .email]
//
//        let authorizationController = ASAuthorizationController(authorizationRequests: [appleIDRequest])
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
//    }
//    @available(iOS 13.0, *)
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        debugE(#function, error)
//        AuthHelper.logout()
//    }
//    @available(iOS 13.0, *)
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        switch authorization.credential {
//            case let appleIDCredential as ASAuthorizationAppleIDCredential:
//
//                // Create an account in your system.
//                let userIdentifier = appleIDCredential.user
//                let fullName = appleIDCredential.fullName
//                let name = "\(fullName?.givenName ?? "") \(fullName?.familyName ?? "")"
//                let email = appleIDCredential.email
//
//                debugE(#function,"grant")
//                // First Grant
//                if let email = email, fullName != nil{
//                    AppModel.shared.appleIDEmail = email
//                    AppModel.shared.appleIDFullName = name
//                }
//                DispatchQueue.main.async {[weak self] in
//                    self?.snsLogin(
//                        .apple,
//                        userIdentifier,
//                        nil,
//                        AppModel.shared.appleIDFullName,
//                        AppModel.shared.appleIDEmail
//                    )
//            }
//
//
//            default:
//                break
//        }
//    }
//
//
//}

extension LoginVC: NaverThirdPartyLoginConnectionDelegate {
  // 로그인 버튼을 눌렀을 경우 열게 될 브라우저
  func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
//     let naverSignInVC = NLoginThirdPartyOAuth20InAppBrowserViewController(request: request)!
//     naverSignInVC.parentOrientation = UIInterfaceOrientation(rawValue: UIDevice.current.orientation.rawValue)!
//     present(naverSignInVC, animated: false, completion: nil)
  }
  
  // 로그인에 성공했을 경우 호출
  func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    print("[Success] : Success Naver Login")
    getNaverInfo()
  }
  
  // 접근 토큰 갱신
  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    
  }
  
  // 로그아웃 할 경우 호출(토큰 삭제)
  func oauth20ConnectionDidFinishDeleteToken() {
    loginInstance?.requestDeleteToken()
  }
  
  // 모든 Error
  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    print("[Error] :", error.localizedDescription)
  }
}
