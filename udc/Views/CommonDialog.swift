//
//  CommonDialog.swift
//  udc
//
//  Created by 도로맥 on 2021/08/12.
//


import UIKit
import MaterialComponents

class CommonDialog : UIView{
    
    class Builder{
        private var iconImage : UIImage = UIImage(named: "info")!
        private var titleStr : String = ""
        private var rightButtonText : String = ""
        private var rightButtonColor : UIColor = .theme
        private var bodyStr : String?
        private var leftButtonText : String?
        private var leftButtonColor : UIColor?
        private var onRightButtonClick : ((String) -> Void)?
        private var onLeftButtonClick : (() -> Void)?
        private var onDismiss : (() -> Void)?
        private var textViewEnable : Bool = false
        private var textViewStr : String = ""
        private var textViewMaxLength : Int = -1
        
        func setTextView(enable : Bool, text : String = "", maxLen : Int = -1) -> Self{
            self.textViewEnable = enable
            self.textViewStr = text
            self.textViewMaxLength = maxLen
            return self
        }
        
        func setIcon(image : UIImage?) -> Self{
            guard image != nil else { return self }
            self.iconImage = image!
            return self
        }
        func setIcon(named : String) -> Self{
            guard let image = UIImage(named: named) else { return self}
            self.iconImage = image
            return self
        }
        
        func setTitle(_ title : String) -> Self{
            self.titleStr = title
            return self
        }
        
        func setBody(_ text : String) -> Self{
            self.bodyStr = text
            return self
        }
        
        func setRightButtonText(_ text : String) -> Self{
            self.rightButtonText = text
            return self
        }
        
        func setRightButtonColor(_ color : UIColor) -> Self{
            self.rightButtonColor = color
            return self
        }
        
        func setLeftButtonText(_ text : String) -> Self{
            self.leftButtonText = text
            return self
        }
        
        func setLeftButtonColor(_ color : UIColor) -> Self{
            self.leftButtonColor = color
            return self
        }
        
        func setOnRightButtonClickListener(_ listener : @escaping (String) -> Void) -> Self{
            self.onRightButtonClick = listener
            return self
        }
        
        func setOnLeftButtonClickListener(_ listener : @escaping () -> Void) -> Self{
            self.onLeftButtonClick = listener
            return self
        }
        
        func setOnDismissListener(_ listener : @escaping () -> Void) -> Self{
            self.onDismiss = listener
            return self
        }
        
        func show(){
            CommonDialog.showDialog(
                iconImage, titleStr, rightButtonText, rightButtonColor, bodyStr,
                leftButtonText, leftButtonColor, onRightButtonClick, onLeftButtonClick, onDismiss,
            textViewEnable,textViewStr,textViewMaxLength)
        }
    }
    
    static func show(error: Error){
        if let title = error.errorCode?.localizedDescription{
            CommonDialog.show(title)
        }else{
            CommonDialog.show(Str.error_common)
        }
    }
    
    static func show(_ title : String){
        CommonDialog.Builder().setTitle(title).setRightButtonText("확인").show()
    }
    
    class func showDialog(
        _ icon : UIImage,
        _ title : String,
        _ rightButtonText : String,
        _ rightButtonColor : UIColor,
        _ body : String? = nil,
        _ leftButtonText : String? = nil,
        _ leftButtonColor : UIColor? = nil,
        _ onRightButtonClick : ((String) -> Void)? = nil,
        _ onLeftButtonClick : (() -> Void)? = nil,
        _ onDismiss : (() -> Void)? = nil,
        _ enableTextView : Bool = false,
        _ textViewStr : String = "",
        _ textViewMaxLength : Int = -1
        ){
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let dialog = CommonDialog(icon, title, rightButtonText, rightButtonColor,
                                  body, leftButtonText, leftButtonColor, onRightButtonClick,
                                  onLeftButtonClick, onDismiss, enableTextView,textViewStr,textViewMaxLength)
        
        let bg = UIView(bgColor: UIColor.black.withAlphaComponent(0.3))
        
        bg.tag = 999
        bg.addSubview(dialog)
        dialog.activateCenterConstraints(to: bg)
        let views = ["dialog" : dialog, "bg" : bg]
        dialog.heightAnchor.constraint(greaterThanOrEqualToConstant: 140).isActive = true
        bg.addConstraints("|-24-[dialog]-24-|", views: views)
        
        bg.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CommonDialog.onClickBackground(_:)))
        bg.addGestureRecognizer(tap)
        
        window.addSubview(bg)
        bg.activateCenterConstraints(to: window)
        window.addConstraints("|[bg]|", views: views)
        window.addConstraints("V:|[bg]|", views: views)
        
        
        /// Animation
        bg.alpha = 0
        if enableTextView{
            dialog.startDialogDropAnimation(extraTranslationY: -50)
            dialog.transform = CGAffineTransform(translationX: 0, y: -50)
        }else{
            dialog.startDialogDropAnimation()
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            bg.alpha = 1
        })
    }
    
    @objc class func onClickBackground(_ gestureRecognizer : UITapGestureRecognizer){
        dismissDialog()
    }
    class func dismissDialog(){
        guard let window = UIApplication.shared.keyWindow else { return }
        for view in window.subviews{
            if view.tag == 999{
                (view.subviews[0] as! CommonDialog).onDismiss?()
                view.removeFromSuperview()
            }
        }
    }
    
    // MARK: -  Views
    private let icon = UIImageView()
    private let title = UILabel()
    private let body = UILabel()
    private let leftButton = RoundButton(heightType: .Height24)
    private let rightButton = RoundButton(heightType: .Height24)
    private let textView = EXTextView()
    
    // MARK: -  Values
    private var iconImage : UIImage = UIImage(named: "info")!
    private var titleStr : String = ""
    private var rightButtonText : String = ""
    private var rightButtonColor : UIColor = .theme
    private var bodyStr : String?
    private var leftButtonText : String?
    private var leftButtonColor : UIColor?
    private var onRightButtonClick : ((String) -> Void)?
    private var onLeftButtonClick : (() -> Void)?
    private var onDismiss : (() -> Void)?
    private var enableTextView : Bool = false
    private var textViewStr : String = ""
    private var textViewMaxLength : Int = -1
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(    _ icon : UIImage,
                         _ title : String,
                         _ rightButtonText : String,
                         _ rightButtonColor : UIColor,
                         _ body : String? = nil,
                         _ leftButtonText : String? = nil,
                         _ leftButtonColor : UIColor? = nil,
                         _ onRightButtonClick : ((String) -> Void)? = nil,
                         _ onLeftButtonClick : (() -> Void)? = nil,
                         _ onDismiss : (() -> Void)? = nil,
                         _ enableTextView : Bool = false,
                         _ textViewStr : String = "",
                         _ textViewMaxLength : Int = -1){
        self.init(frame : .zero)
        
        self.iconImage = icon
        self.titleStr = title
        self.rightButtonText = rightButtonText
        self.rightButtonColor = rightButtonColor
        self.bodyStr = body
        self.leftButtonText = leftButtonText
        self.leftButtonColor = leftButtonColor
        self.onRightButtonClick = onRightButtonClick
        self.onLeftButtonClick = onLeftButtonClick
        self.onDismiss = onDismiss
        self.enableTextView = enableTextView
        self.textViewStr = textViewStr
        self.textViewMaxLength = textViewMaxLength
        
        setup()
    }
    
    private func setup(){
        //Auto Resizing mask off
        self.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        body.translatesAutoresizingMaskIntoConstraints = false
        
        //View
        self.backgroundColor = UIColor.surfaceBlack
        self.layer.cornerRadius = 8
        
        //Child Views
        icon.contentMode = .scaleAspectFit
        title.font = .bold13
        title.textColor = .white
        title.numberOfLines = 0
        body.font = .regular13
        body.textColor = .white
        body.numberOfLines = 0
//        textView.insetHorizontal = 8
//        textView.insetVertical = 8
        textView.layer.cornerRadius = 4
        textView.borderWidth = 1
        textView.borderColor = UIColor.textFieldBorder
        
        
        //Value Set
        icon.image = iconImage
        title.text = titleStr
        body.text = bodyStr
        leftButton.setTitle(leftButtonText, for: .normal)
        leftButton.setBackgroundColor(leftButtonColor)
        leftButton.addTarget(self, action: #selector(onLeftButtonClicked), for: .touchUpInside)
        rightButton.setTitle(rightButtonText,for:.normal)
        rightButton.setBackgroundColor(rightButtonColor)
        rightButton.addTarget(self, action: #selector(onRightButtonClicked), for: .touchUpInside)
        textView.text = self.textViewStr
        
        
        //Add Views
        self.addSubview(icon)
        self.addSubview(title)
        self.addSubview(rightButton)
        
        
        //Add Constraints
        let views = ["icon" : icon,"title" : title, "body" : body,"leftButton" : leftButton,"rightButton" : rightButton,"textView" : textView]
        
        icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        addConstraints("H:|-12-[icon]-8-[title]-12-|",options: [.alignAllTop], views: views)
        
        //If have body String
        if enableTextView{
            self.addSubview(textView)
            addConstraints("|-12-[textView]-12-|", views: views)
            addConstraints("V:|-12-[icon]-12@250-[textView(126@1000)]-12@250-[rightButton]-12-|", views: views)
            textView.delegate = self
        }else if bodyStr != nil {
            self.addSubview(body)
            addConstraints("|-12-[body]-12-|", views: views)
            addConstraints("V:|-12-[icon]-12@250-[body]-12@250-[rightButton]-12-|", views: views)
        }else{
            addConstraints("V:|-12-[icon]-12@250-[rightButton]-12-|", views: views)
        }
        
        if leftButtonText != nil{
            self.addSubview(leftButton)
            addConstraints("[leftButton]-12-[rightButton]-12-|",options: [.alignAllCenterY], views: views)
        }else{
            addConstraints("[rightButton]-12-|", views: views)
        }
        
        sizeToFit()
        
        if enableTextView{
            self.textView.becomeFirstResponder()
        }
    }
    
    @objc private func onLeftButtonClicked(){
        self.onLeftButtonClick?()
        CommonDialog.dismissDialog()
        onLeftButtonClick = nil
        onRightButtonClick = nil
        onDismiss = nil
    }
    @objc private func onRightButtonClicked(){
        self.onRightButtonClick?(self.textView.text ?? "")
        CommonDialog.dismissDialog()
        onLeftButtonClick = nil
        onRightButtonClick = nil
        onDismiss = nil
    }
}

extension CommonDialog: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.textViewMaxLength < 0 { return true }
        guard let originalText = textView.text else { return true }
        
        let newText = NSString(string: originalText).replacingCharacters(in: range, with: text)
        
        return newText.count <= textViewMaxLength
    }
}
