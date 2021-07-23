//
//  EventUploadVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/23.
//
import UIKit

final class EventUploadVC : EXViewController {
    
    private let scrollView = UIScrollView()
    
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
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureTPNavigationBar()
        
        self.view.backgroundColor = .green
        
        initNavigationBar()
        initView()
        
        debugE("EVENT")
    }
    
    private func initNavigationBar() {
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)

        let navItem = UINavigationItem(title: "행사 등록하기")
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(done))
        navItem.rightBarButtonItem = doneItem

        navBar.setItems([navItem], animated: false)

    }
    
    @objc func done() { // remove @objc for Swift 3

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
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
            "eventDateLabel" : eventDateLabel
        ]
        
        view.addConstraints("|[scrollView]|", views: views)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.addConstraints("|[container]|", views: views)
        scrollView.addConstraints("V:|[container]|", views: views)
        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: 2000).isActive = true
        
        container.addSubviews(pickPosterLabel, pickGalleryImage, pickSketchesLabel, eventNameLabel, eventDescriptionLabel, eventLocationLabel, eventDateLabel)
        
        
        container.addConstraints("|-24-[pickPosterLabel]-24-|", views: views)
        container.addConstraints("|-16-[pickGalleryImage]|", views: views)
        
        
        
        container.addConstraints("V:|-0@250-[pickPosterLabel(120)]-16-[pickGalleryImage]-|", views: views)
        
        
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
