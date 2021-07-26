//
//  EventUploadVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/23.
//
import UIKit

final class EventUploadVC : EXViewController {
    
    private let scrollView = UIScrollView()
    
    @objc var backArrowTapHandler: (() -> Void)?
    
    private var pickPosterLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사 포스터"
        v.font = .bold13
        v.textColor = .white
        return v
    }()
    
    private var pickSketchesLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사 상세 사진"
        v.font = .bold13
        v.textColor = .white
        return v
    }()
    
    private var eventNameLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사명"
        v.font = .bold13
        v.textColor = .white
        return v
    }()
    
    private var eventDescriptionLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사 소개"
        v.font = .bold13
        v.textColor = .white
        return v
    }()
    
    private var eventLocationLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사 장소"
        v.font = .bold13
        v.textColor = .white
        return v
    }()
    
    private var eventDateLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사 일정"
        v.font = .bold13
        v.textColor = .white
        return v
    }()
    
    private var eventTypeLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사 종류"
        v.font = .bold13
        v.textColor = .white
        return v
    }()
    
    private lazy var titleField : CommonTextField = {
        let v = CommonTextField()
        v.delegate = self
        return v
    }()
    
    private lazy var descriptionField : CommonTextField = {
        let v = CommonTextField()
        v.delegate = self
        return v
    }()
    
    private lazy var pickGalleryImage : UIImageView = {
        let v = UIImageView(named: "camera")
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 24).isActive = true
        v.heightAnchor.constraint(equalToConstant: 24).isActive = true
        v.contentMode = .scaleAspectFit
        v.shadowRadius = 5
        v.shadowOpacity = 0.1
        v.shadowColorExtension = .black
        return v
    }()
    
    
    private lazy var tapBackArrowGesture: UITapGestureRecognizer = {
        let t = UITapGestureRecognizer()
        t.addTarget(self, action: #selector(backArrowTapped(_ :)))
        return t
    }()
    
    
    private lazy var backArrowImage : UIImageView = {
        
        let v = UIImageView(named: "backarrow")
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 24).isActive = true
        v.heightAnchor.constraint(equalToConstant: 24).isActive = true
        v.contentMode = .scaleAspectFit
        v.addGestureRecognizer(self.tapBackArrowGesture)
        
        return v
        
    }()
    
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureTPNavigationBar()
        
        self.view.backgroundColor = .green
        
        initView()
        
        debugE("EVENT")
        
        backArrowTapHandler = { [unowned self] in
            debugE("back arrow tap handler")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @objc func done() { // remove @objc for Swift 3

    }
    
    
    private func initView() {
        

        /// 스크롤 뷰
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.zOrder = -1
        
        /// 스크롤 뷰 안 Container
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(container)
        
        let views = [
            "scrollView" : scrollView,
            "container" : container,
            "pickPosterLabel" : pickPosterLabel,
            "pickSketchesLabel" :pickSketchesLabel,
            "pickGalleryImage": pickGalleryImage,
            "eventNameLabel" : eventNameLabel,
            "eventDescriptionLabel" : eventDescriptionLabel,
            "eventLocationLabel" :eventLocationLabel,
            "eventDateLabel" : eventDateLabel,
            "backArrowImage" : backArrowImage
        ]
        
        view.addConstraints("|[scrollView]|", views: views)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.addConstraints("|[container]|", views: views)
        scrollView.addConstraints("V:|[container]|", views: views)
        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: 2000).isActive = true
        
        container.addSubviews(pickPosterLabel, pickGalleryImage, pickSketchesLabel, eventNameLabel, eventDescriptionLabel, eventLocationLabel, eventDateLabel, backArrowImage)
        
        
        container.addConstraints("H:|-16-[backArrowImage]", views : views )
        container.addConstraints("H:|-24-[pickPosterLabel]-24-|", views: views)
        container.addConstraints("H:|-16-[pickGalleryImage]|", views: views)
        container.addConstraints("H:|-16-[pickSketchesLabel]-16-|", views :views)
        container.addConstraints("H:|-16-[pickGalleryImage]|", views: views)
        container.addConstraints("H:|-16-[eventNameLabel]", views: views)
        container.addConstraints("H:|-16-[eventDescriptionLabel]|", views: views)
        container.addConstraints("H:|-16-[eventLocationLabel]|" , views: views)
        container.addConstraints("H:|-16-[eventDateLabel]|", views : views)
        
    
        container.addConstraints("V:|-24-[backArrowImage]-50-[pickPosterLabel]-16-[pickGalleryImage]-16-[pickGalleryImage]-16-[pickSketchesLabel]-16-[eventNameLabel]-16-[eventDescriptionLabel]-16-[eventLocationLabel]-16-[eventDateLabel]", views: views)
        
        
    }
    
    @objc func backArrowTapped(_ sender : UITapGestureRecognizer){
        backArrowTapHandler?()
    }
}

extension EventUploadVC :  UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        switch textField{
//            case nicknameTextField:
//            isNameChanged = true
//            case userNameTextField:
//            isUserNameChanged = true
//            default:
//            break
//        }
        return true
    }
}
