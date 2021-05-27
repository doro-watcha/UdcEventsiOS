//
//  Splash.swift
//  udc
//
//  Created by 도로맥 on 2021/05/26.
//

import Foundation
import UIKit

final class LayoutHelper {
    
    static let shared = LayoutHelper()
    
    var safeAreaInsets: UIEdgeInsets = .zero
    
    // 디자인 시안의 width 360를 기준으로 했을때 값이 value인 경우,
    // 현재 기기의 width를 기준으로 했을때의 값을 리턴
    // 예를들어 디자인 시안의 height값을 고정으로 적용하지 않고 기기별 width에 따라 비율로 적용하고자 할때등 사용
    func adjustedValueForTemplateValue(_ value: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width * value / 360
    }
    
}

final class SplashVC: EXViewController {
    
    static var needLoginProcess = false
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    // LayoutHelper.shared.safeAreaInsets 설정 위한 용도
    private let safeAreaView = UIView(bgColor: .clear)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugE("REAL?")

        view.addSubview(safeAreaView)
        NSLayoutConstraint.activate([
            safeAreaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            safeAreaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            safeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            safeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setGradientBackground()
        let top = safeAreaView.frame.origin.y
        let bottom = UIScreen.main.bounds.height - (top + safeAreaView.bounds.height)
        LayoutHelper.shared.safeAreaInsets = UIEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        processBootup()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(processBootup), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func processBootup() {
        /**
        권한 안내 페이지를 본 적이 없다면 보여준다.
        */
//        if !AppModel.shared.permissionInformationScreenSeen{
//            self.presentPermission()
//            AppModel.shared.permissionInformationScreenSeen = true
//            return
//        }
//
        /**
        현재 최신 버전 및 약관동의 버전 Check
        */
        //CommonService.getApplicationVersionAndLatestLegalNoticeVersion().done{response in
            
//            /** 추후에 서버에서 Default Server를 바꾸어주어야 한다면 서버에서 받은 응답에 따라 바꾼다(현재 쓰이지는 않음)*/
//            if let server = response.defaultServer{
//                AppModel.shared.serviceEnvironment = server.rawValue
//            }
//
//            /** Save Latest Legal Notice Version to AppModel
//            * (로그인 시에 쓰이지는 않음, 가장 최신 버전을 저장만 해두고 TermsConfirmVC 에서 유저가 동의 시에 같이 쏴주기 위한 값을 미리 저장)
//            */
//            AppModel.shared.latestLegalNoticeVersion = response.latestLegalNoticeVersion
//
//            /** Version Check for Force update */
//            if VersionHelper.checkAppNeedForceUpdate(minimumVersionNameFromServerRaw: response.minimumVersionName){
//                self.presentVersion()
//                return
//            }
//
//            /** 만약 로그인이 필요해서 이 화면으로 다시 온것이라면, IntroVC로 보내준다 */
//            if SplashVC.needLoginProcess{
//                SplashVC.needLoginProcess = false
//                /**
//                로그인 상태가 아니라서 로그인 화면으로 보내주어야 할 때
//                */
//                if AppModel.shared.accessToken.isEmpty {
//                    self.presentNavigationController(IntroVC(), animated: false)
//                    return
//                }
//            }
//
//            /** 자동 로그인이 되어있는 유저라면(로컬에 access token이 남아있다면),
//            서버에 토큰 Validation 확인 및 정책이 업데이트 되었는 지 확인해주고 성공 시에 자동로그인을 실행한다.
//            */
//            if self.isLogined{
//                User.checkTokenValidation().done{[unowned self] _ in
//                    self.presentVC(TabBarVC(), animated: true)
//                    UserDevice.registerUserDevice()
//                }.catch{e in
//                    switch e.errorCode{
//                        /** 토큰 만료, 새로운 정책 */
//                        case .tokenInvalid ,.termsOfAgreeNotAgreed:
//                            // TODO: Show Token Invalidation Dialog
//                            AuthHelper.logout()
//                            CommonDialog.Builder().setTitle(e.errorCode?.localizedDescription ?? "Token Expired")
//                                .setRightButtonText(Str.common_ok)
//                                .setOnDismissListener {[unowned self] in
//                                    self.presentNavigationController(IntroVC(), animated: false,completion: {
//                                        CommonDialog.show(error: e)
//                                    })
//                            }.show()
//                        default:
//                            self.presentVC(TabBarVC(), animated: true)
//                    }
//                }
//            }else{
//
//            }
        self.presentVC(TabBarVC(), animated: true)
        
//        }.catch{e in
//            let errorMessage: String?
//            if e is ServiceError{
//                errorMessage = e.errorCode?.localizedDescription
//            }else{
//                errorMessage = ErrorCode.networkDisconnected.localizedDescription
//            }
//
//            if let errorMessage = errorMessage{
//                CommonDialog.Builder().setTitle(errorMessage)
//                    .setRightButtonText(Str.common_ok)
//                    .setOnDismissListener {
//                        self.presentNavigationController(IntroVC(), animated: false)
//                }.show()
//            }
//        }
    }
}
