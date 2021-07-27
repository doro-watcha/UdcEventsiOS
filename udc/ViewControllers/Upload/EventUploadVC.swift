//
//  EventUploadVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/23.
//
import UIKit
import MaterialComponents

final class EventUploadVC : EXViewController, UIGestureRecognizerDelegate {
    
    private let scrollView = UIScrollView()
    
    @objc var backArrowTapHandler: (() -> Void)?
    @objc var datePickTapHandler:( () -> Void)?
    @objc var locationPickTapHandler: (() -> Void)?
    
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
        v.placeholder = "행사명을 알려주세요!"
        return v
    }()
    
    private lazy var descriptionTextView : CommonTextView = {
        let v = CommonTextView()
        v.delegate = self
//        v.placeholder = "행사에 대한 설명을 알려주세요!"
//        v.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return v
    }()
    
    private lazy var locationBoxLabel : BoxLabel = {
        
        let v = BoxLabel()
        v.text = "행사 장소를 골라주세요!"
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(locationPickGesture)
        return v
        
    }()
    
    private lazy var dateBoxLabel : BoxLabel = {
        let v = BoxLabel()
        v.text = "행사 날짜를 골라주세요!"
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(datePickGesture)
        return v
    }()
    
    private lazy var typeBoxLabel : BoxLabel = {
        let v = BoxLabel()
        v.text = "행사 종류를 골라주세요!"
        
        return v
    }()
    
    private lazy var pickGalleryImage : ImagePickerView = {
        let v = ImagePickerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4 ).isActive = true
        v.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(imagePickerGesture)
        return v
    }()
    
    private lazy var posterImageView : EXImageView = {
        let v = EXImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = CGFloat(4)
        v.layer.masksToBounds = true
        v.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4 ).isActive = true
        v.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        v.isHidden = true
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
    
    
    private lazy var datePickGesture : UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(datePickTapped(_:)))
        tap.delegate = self
        return tap
    }()
    
    private lazy var locationPickGesture : UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(locationPickTapped(_:)))
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
    
    private lazy var uploadButton : RoundButton = {
        let v = RoundButton(heightType: .Height36)
        v.text = "행사 등록하기"
        v.backgroundColor = .black
        v.setTitleColor(.white, for: .normal)
        v.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
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
        
        datePickTapHandler = { [unowned self] in
            debugE("back arrow tap handler")
            self.presentPickDate()
        }
        locationPickTapHandler = { [unowned self] in
            
            self.presentPickLocation()
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
            "eventTypeLabel" : eventTypeLabel,
            "backArrowImage" : backArrowImage,
            "titleLabel" : titleLabel,
            "posterImageView" : posterImageView,
            "titleField" : titleField,
            "descriptionTextView" : descriptionTextView,
            "locationBoxLabel" : locationBoxLabel,
            "dateBoxLabel" : dateBoxLabel,
            "typeBoxLabel" : typeBoxLabel,
            "uploadButton" : uploadButton
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
        container.addSubview(posterImageView)
        container.addSubview(eventNameLabel)
        container.addSubview(eventDescriptionLabel)
        container.addSubview(eventLocationLabel)
        container.addSubview(eventTypeLabel)
        container.addSubview(eventDateLabel)
        container.addSubview(titleField)
        container.addSubview(descriptionTextView)
        container.addSubview(locationBoxLabel)
        container.addSubview(dateBoxLabel)
        container.addSubview(typeBoxLabel)
        container.addSubview(uploadButton)
        

        

        container.addConstraints("H:|-16-[pickPosterLabel]|", views: views)
        container.addConstraints("H:|-16-[pickGalleryImage]-15-[posterImageView]", views: views)
        container.addConstraints("H:|-16-[pickSketchesLabel]|", views :views)
        container.addConstraints("H:|-16-[titleField]-16-|", views: views)
//        container.addConstraints("H:|-16-[pickSketchImage]|", views: views)
        container.addConstraints("H:|-16-[eventNameLabel]", views: views)
        container.addConstraints("H:|-16-[eventDescriptionLabel]|", views: views)
        container.addConstraints("H:|-16-[descriptionTextView]-16-|", views : views )

        container.addConstraints("H:|-16-[eventLocationLabel]|" , views: views)
        container.addConstraints("H:|-16-[eventTypeLabel]", views : views )
        container.addConstraints("H:|-16-[eventDateLabel]|", views : views)
        container.addConstraints("H:|-16-[locationBoxLabel]-16-|", views: views )
        container.addConstraints("H:|-16-[dateBoxLabel]-16-|", views: views )
        container.addConstraints("H:|-16-[typeBoxLabel]-16-|", views: views )
        container.addConstraints("H:|-16-[uploadButton]-16-|", views: views )
    
        
        posterImageView.topAnchor.constraint(equalTo: pickGalleryImage.topAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: pickGalleryImage.bottomAnchor).isActive = true
//
    
        container.addConstraints("V:|-20-[pickPosterLabel]-[pickGalleryImage]-[pickSketchesLabel]-[eventNameLabel]-[titleField(45)]-[eventDescriptionLabel]-[descriptionTextView(150)]-16-[eventLocationLabel]-16-[locationBoxLabel(45)]-16-[eventDateLabel]-16-[dateBoxLabel(45)]-16-[eventTypeLabel]-16-[typeBoxLabel(45)]-16-[uploadButton]", views: views)
        
        
    }
    @objc func datePickTapped (_ sender : UITapGestureRecognizer){
        datePickTapHandler?()
    }
    @objc func backArrowTapped(_ sender : UITapGestureRecognizer){
        backArrowTapHandler?()
    }
    @objc func locationPickTapped (_ sender :UITapGestureRecognizer) {
        locationPickTapHandler?()
    }
    
    @objc private func imagePickerTapped(){
        self.presentImagePicker(self)
    }
    
    @objc private func uploadButtonTapped(){
        
        /// Email Empty
        guard let title = titleField.text, titleField.text?.isEmpty == false else{
          //  showEmailErrorMessage(message: Str.error_email_empty)
            return
        }

        
        /// Password Empty
        guard let description = descriptionTextView.text, descriptionTextView.text?.isEmpty == false else{
        //    showPasswordErrorMessage(message: Str.error_password_empty)
            return
        }
        
//    
//        
//        Event.signIn(withEmail: email, password: password,acceptedLegalNoticeVersion: nil).done { user in
//            self.dismiss(animated: true, completion: nil)
//        }.catch {[unowned self] e in
//            
//            switch e.errorCode{
//                case .emailUnverified:
//                    self.showEmailVerificationErrorDialog(e: e.errorCode!)
//                    break;
//                case .termsOfAgreeNotAgreed:
//                    CommonDialog.show(error: e)
//                    self.presentTermsConfirm(usedSignUp: false,loginType: .email, socialUuid: nil, name: nil, email: email, avatarUrl: nil, password: password)
//                case .userNotFound:
//                    self.showEmailErrorMessage(message: e.errorCode!.localizedDescription)
//                    break
//                case .passwordInvalid:
//                    self.showPasswordErrorMessage(message: e.errorCode!.localizedDescription)
//                    break
//                default:
//                    CommonDialog.show(error: e)
//                break
//            }
//        }.finally {
//            self.hideProgress()
//        }

    }
    
    
    /** 이미지 고르는 화면 - UIImagePickerController */
    func presentImagePicker(_ delegate : UIImagePickerControllerDelegate & UINavigationControllerDelegate){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = delegate
        self.presentModal(vc)
    }
    
    func presentPickDate () {
        
        let vc = DatePickVC()
        let bottomSheetVC = MDCBottomSheetController(contentViewController: vc)
        bottomSheetVC.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
        present(bottomSheetVC, animated: true, completion: nil)

    }
    
    func presentPickLocation () {
        
        let vc = LocationPickVC()
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
        
        posterImageView.image = image
        posterImageView.isHidden = false
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EventUploadVC: UITextViewDelegate, UITextFieldDelegate{
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        switch textField{
//            case nicknameTextField:
//            isNameChanged = true
//            case userNameTextField:
//            isUserNameChanged = true
//            default:
//            break
//        }
//        return true
//    }
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let newString = NSString(string: textView.text).replacingCharacters(in: range, with: text)
//
//        switch textView{
//            case bioTextView:
//                isBioChanged = true
//                return newString.count <= Constant.MAX_BIO_LEN
//            case credentialsTextView:
//                isCredentialsChanged = true
//                return newString.count <= Constant.MAX_CREDENTIALS_LEN
//            default:
//                return true
//        }
//    }
}
