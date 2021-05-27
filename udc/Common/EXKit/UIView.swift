//
//  UIView.swift
//  udc
//
//  Created by 도로맥 on 2021/05/26.
//


import UIKit

extension UIView{
    class var identifier: String{
        return String(describing: self)
    }
    
    func addSubviews(_ views : UIView...){
        for v in views{
            addSubview(v)
        }
    }
    var isVisible: Bool{
        get{
            return !isHidden
        }set{
            isHidden = !newValue
        }
    }
}

extension UIView {
    
    func addConstraints(_ format: String, views: [String : Any]) {
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: views))
    }
    
    func addConstraints(_ format: String,metrics: [String : Any]? ,  views: [String : Any]) {
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,options: [], metrics: metrics, views: views))
    }
    
    func addConstraints(_ format: String,options: NSLayoutConstraint.FormatOptions ,  views: [String : Any]) {
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: nil, views: views))
    }
    
    func addConstraints(_ format: String, options opts: NSLayoutConstraint.FormatOptions = [], metrics: [String : Any]?, views: [String : Any]) {
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: opts, metrics: metrics, views: views))
    }
    
    func activateCenterConstraints(to target:UIView) {
        self.centerXAnchor.constraint(equalTo: target.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: target.centerYAnchor).isActive = true
    }
    
    func activateCenterXConstraint(to target:UIView) {
        self.centerXAnchor.constraint(equalTo: target.centerXAnchor).isActive = true
    }
    
    func activateCenterYConstraint(to target:UIView) {
        self.centerYAnchor.constraint(equalTo: target.centerYAnchor).isActive = true
    }
    
    convenience init(bgColor: UIColor) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = bgColor
    }
    
}


extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIView {
    @IBInspectable
    var zOrder : Int{
        get{
            return Int(layer.zPosition)
        }
        set(value){
            layer.zPosition = CGFloat(value)
        }
    }
    
    func setRoundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffsetExtension: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColorExtension: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}


extension UIView {
    
    static var keyboardBindingObservers : [NSObjectProtocol] = []
    
    func bindToKeyboard(_ willShow : ((TimeInterval, CGFloat) -> Void)? = nil, _ willHide : ((TimeInterval, CGFloat) -> Void)? = nil){
        let showObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main){ notification in
            guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
            guard let curFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardHeight = curFrame.cgRectValue.height
            willShow?(duration,keyboardHeight)
        }
        
        let hideObserver = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main){ notification in
            guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
            guard let curFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardHeight = curFrame.cgRectValue.height
            willHide?(duration,keyboardHeight)
        }
        
        UIView.keyboardBindingObservers.append(showObserver)
        UIView.keyboardBindingObservers.append(hideObserver)
    }
    
    static func unbindFromKeyboard(){
        for observer in self.keyboardBindingObservers{
            NotificationCenter.default.removeObserver(observer)
        }
    }
}

extension UIView{
    func startShakeAnimation(){
        
        //Animation for scale
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        
        //Animation Duration
        animation.duration = 0.02
        
        //Animation KeyTimes
        animation.keyTimes = [0.0,1.0]
        
        //Animation Values
        animation.values = [0.0,1.5]
        
        animation.autoreverses = true
        
        //Interpolator
        animation.calculationMode = .linear
        
        animation.repeatCount = 16
        //DELAY
//        animation.beginTime = CACurrentMediaTime() + 3.0
        
        //PLAY
        self.layer.add(animation, forKey: nil)
    }
    
    func startDialogDropAnimation(extraTranslationY: CGFloat = 0){
        //Animation for scale
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        
        //Animation Duration
        animation.duration = 0.2
        
        //Animation KeyTimes
        animation.keyTimes = [0.0,1.0]
        
        //Animation Values
        animation.values = [50.0,0 + extraTranslationY]
        
        //Interpolator
        animation.calculationMode = .cubic
        
        //PLAY
        self.layer.add(animation, forKey: nil)
    }
}
