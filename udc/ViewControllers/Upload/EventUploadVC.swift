//
//  EventUploadVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/23.
//
import UIKit

final class EventUploadVC : EXViewController, UIGestureRecognizerDelegate {
    
    private let scrollView = UIScrollView()
    
    @objc var backArrowTapHandler: (() -> Void)?
    
    private var titleLabel : UILabel = {
        
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사 등록하기"
        v.font = .bold13
        v.textColor = .black
        
        return v
    }()
    
    private var pickPosterLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사 포스터"
        v.font = .bold13
        v.textColor = .black
        return v
    }()
    
    private var pickSketchesLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사 상세 사진"
        v.font = .bold13
        v.textColor = .black
        return v
    }()
    
    private var eventNameLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사명"
        v.font = .bold13
        v.textColor = .black
        return v
    }()
    
    private var eventDescriptionLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사 소개"
        v.font = .bold13
        v.textColor = .black
        return v
    }()
    
    private var eventLocationLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사 장소"
        v.font = .bold13
        v.textColor = .black
        return v
    }()
    
    private var eventDateLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사 일정"
        v.font = .bold13
        v.textColor = .black
        return v
    }()
    
    private var eventTypeLabel : UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "행사 종류"
        v.font = .bold13
        v.textColor = .black
    
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
    
    private lazy var pickGalleryImage : ImagePickerView = {
        let v = ImagePickerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4 ).isActive = true
        v.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
//        v.frame.size.width = UIScreen.main.bounds.width / 4
//        v.contentMode = .scaleAspectFit
//        v.shadowRadius = 5
//        v.shadowOpacity = 0.1
//        v.shadowColorExtension = .black
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(imagePickerGesture)
        return v
    }()
    
    
    private lazy var tapBackArrowGesture: UITapGestureRecognizer = {
        let t = UITapGestureRecognizer()
        t.addTarget(self, action: #selector(backArrowTapped(_ :)))
        return t
    }()
    
    private lazy var imagePickerGesture : UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imagePickerTapped))
        tap.delegate = self
        return tap
    }()
    
    
    
    private lazy var backArrowImage : UIImageView = {
        
        let v = UIImageView(named: "backarrow")
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 24).isActive = true
        v.heightAnchor.constraint(equalToConstant: 24).isActive = true
        v.contentMode = .scaleAspectFit
        v.image = v.image!.withRenderingMode(.alwaysTemplate)
        v.tintColor = .black
        v.addGestureRecognizer(self.tapBackArrowGesture)
        
        return v
        
    }()
    
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureTPNavigationBar()
        
        self.view.backgroundColor = .white
        
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
        scrollView.bounces = false
        
        /// 스크롤 뷰 안 Container
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews(scrollView, backArrowImage, titleLabel)
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
            "backArrowImage" : backArrowImage,
            "titleLabel" : titleLabel
        ]
        
        view.addConstraints("H:|[scrollView]|", views: views)
        view.addConstraints("H:|-16-[backArrowImage]-10-[titleLabel]", views : views )
        view.addConstraints("V:|-50-[backArrowImage]-[scrollView]|" , views : views)
        
        titleLabel.topAnchor.constraint(equalTo: backArrowImage.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: backArrowImage.bottomAnchor).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: backArrowImage.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.addConstraints("|[container]|", views: views)

        scrollView.addConstraints("V:|[container]|", views: views)
        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: 2000).isActive = true
        
       // container.addSubviews(pickPosterLabel, pickGalleryImage, pickSketchesLabel, eventNameLabel, eventDescriptionLabel, eventLocationLabel, eventDateLabel)
        container.addSubview(pickPosterLabel)
        container.addSubview(pickGalleryImage)
//        container.addSubview(pickSketchesLabel)
        container.addSubview(pickSketchesLabel)
        

        

        container.addConstraints("H:|-16-[pickPosterLabel]|", views: views)
        container.addConstraints("H:|-16-[pickGalleryImage]", views: views)
        container.addConstraints("H:|-16-[pickSketchesLabel]|", views :views)
//        container.addConstraints("H:|-16-[pickSketchImage]|", views: views)
//        container.addConstraints("H:|-16-[eventNameLabel]", views: views)
//        container.addConstraints("H:|-16-[eventDescriptionLabel]|", views: views)
//        container.addConstraints("H:|-16-[eventLocationLabel]|" , views: views)
//        container.addConstraints("H:|-16-[eventDateLabel]|", views : views)
//
    
        container.addConstraints("V:|-20-[pickPosterLabel]-[pickGalleryImage]-[pickSketchesLabel]", views: views)
        
        
    }
    
    @objc func backArrowTapped(_ sender : UITapGestureRecognizer){
        backArrowTapHandler?()
    }
    
    @objc private func imagePickerTapped(){
        self.presentImagePicker(self)
    }
    
    /** 이미지 고르는 화면 - UIImagePickerController */
    func presentImagePicker(_ delegate : UIImagePickerControllerDelegate & UINavigationControllerDelegate){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = delegate
        self.presentModal(vc)
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


extension EventUploadVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,let url = info[UIImagePickerController.InfoKey.imageURL] as? URL , let data = image.jpegData(compressionQuality: 0.9) else {
            showAlert( "Error", NSLocalizedString("Fail to retreive photo", comment: ""))
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
//        if self.isCoverImageEditing{
//            changeCoverImage(file: UploadFile(data: data, name: "cover", fileName: url.absoluteURL.lastPathComponent , mimeType: "image/*"), image: image)
//
//        }else{
//            changeProfileImage(file: UploadFile(data: data, name: "avatar", fileName: url.absoluteURL.lastPathComponent , mimeType: "image/*"), image: image)
//        }
        picker.dismiss(animated: true, completion: nil)
    }
}
