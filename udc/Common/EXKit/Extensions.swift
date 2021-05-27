//
//  Extensions.swift
//  udc
//
//  Created by 도로맥 on 2021/05/26.
//


import UIKit
import WebKit
import Alamofire
import AVFoundation
import RxSwift


// helper protocl for getting property names of class/struct

protocol PropertyNamesProvider {
    func propertyNames() -> [String]
}

extension PropertyNamesProvider {
    func propertyNames() -> [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
}

// Access properties via subscripting

protocol PropertyReflectable { }

extension PropertyReflectable {
    subscript(key: String) -> Any? {
        let m = Mirror(reflecting: self)
        for child in m.children {
            if child.label == key { return child.value }
        }
        return nil
    }
}





extension Array {
    
    //
    // Array(repeating:count:) 사용시 반복 생성 대상이 레퍼런스 타입인 경우
    // 객체 인스턴스가 반복 생성되지 않고 참조가 반복되는 문제가 있어
    // 레퍼런스 타입 객체의 반복생성을 위한 용도로 사용하기 위해 추가
    //
    init(repeatingObject elementCreator: @autoclosure () -> Element, count: Int) {
        self = (0 ..< count).map { _ in elementCreator() }
    }
    
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
}




extension Bundle {
    
    static func bundleVersion() -> String? {
        guard let dict = Bundle.main.infoDictionary else {
            return nil
        }
        return dict["CFBundleShortVersionString"] as? String
    }
    
    static func bundleBuild() -> String? {
        guard let dict = Bundle.main.infoDictionary else {
            return nil
        }
        return dict["CFBundleVersion"] as? String
    }
    
}



extension Date {
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func weekOfYear() -> (week: Int, year: Int) {
        // 참고: ISO 8601 WeekDates https://ko.wikipedia.org/wiki/ISO_8601#Week_Dates
        var calendar = Calendar.current
        calendar.locale = Locale.init(identifier: "ko_KR")
        calendar.firstWeekday = 2 // Monday
        calendar.minimumDaysInFirstWeek = 4
        let comps = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        return (comps.weekOfYear ?? 0, comps.yearForWeekOfYear ?? 0)
    }
    
    func weekOfYearInterval() -> (start: Date, end: Date) {
        // 참고: ISO 8601 WeekDates https://ko.wikipedia.org/wiki/ISO_8601#Week_Dates
        var calendar = Calendar.current
        calendar.locale = Locale.init(identifier: "ko_KR")
        calendar.firstWeekday = 2 // Monday
        calendar.minimumDaysInFirstWeek = 4
        
        if let interval = calendar.dateInterval(of: .weekOfYear, for: self) {
            return (interval.start, interval.end.addingTimeInterval(-1))
        }
        else {
            return (Date(), Date())
        }
    }
    
    func isInSameYear(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .year)
    }
}



extension DateFormatter {
    
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter
    }()
    
}



extension Double {
    
    /// Rounds the double to decimal places value
    func rounded(toPlace place:Int) -> Double {
        let divisor = pow(10.0, Double(place))
        return (self * divisor).rounded() / divisor
    }
    
    var decimalFormattedString: String {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter.string(for: self) ?? ""
        }
    }
    
}


extension Int {
    
    var decimalFormattedString: String {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter.string(for: self) ?? ""
        }
    }
    
}


extension String {
    
    // NOTE: 툴에서 인식못함
    //    func localized(withComment comment: String? = nil) -> String {
    //        return NSLocalizedString(self, comment: comment ?? "")
    //    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func trimAndRemoveNewlines() -> String {
        return self.trim()
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\r", with: " ")
            .replacingOccurrences(of: "\t", with: " ")
    }
    
    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func attributedString(forKeyword keyword: String, color: UIColor, font: UIFont? = nil, underline: Bool = false) -> NSMutableAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: color]
        if let font = font {
            attributes[.font] = font
        }
        if underline {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        let attrString = NSMutableAttributedString(string: self)
        let regex = try! NSRegularExpression(pattern: keyword, options: [.caseInsensitive])
        let wholeRange = NSRange(location: 0, length: self.count)
        regex.enumerateMatches(in: self, options: [], range: wholeRange) { (result, flags, stop) in
            if let range = result?.range {
                attrString.addAttributes(attributes, range: range)
            }
        }
        
        return attrString
    }
    
    func attributedStringForContent(withTextAlignment alignment: NSTextAlignment = .left, lineSpacing: CGFloat = 5.0) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        let attrString = NSMutableAttributedString(string: self)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        return attrString
    }
    
    var isAlphaNumeric: Bool {
        get {
            let regex = "^[a-zA-Z0-9]*$"
            let test = NSPredicate(format: "SELF MATCHES[c] %@", regex)
            return test.evaluate(with: self)
        }
    }
    
    var isAlphaNumericKorean: Bool {
        get {
            let regex = "^[a-zA-Z0-9ㄱ-ㅣ가-힣ㆍᆢ]*$"
            let test = NSPredicate(format: "SELF MATCHES[c] %@", regex)
            return test.evaluate(with: self)
        }
    }
    
    //    var isSpecialCharacterExist: Bool {
    //        get {
    //            let chSet = CharacterSet(charactersIn: "~!@#$%^&*()-_=+{}[]\\|;:'\",.<>/?")
    //            if let _ = self.rangeOfCharacter(from: chSet) {
    //                return true
    //            }
    //            else {
    //                return false
    //            }
    //        }
    //    }
    
    var urlQueryAllowedString: String {
        get {
            return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
    }
    
}

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
}

extension UIButton {
    
    convenience init(named imageName: String, selectedNamed: String? = nil, title: String? = nil) {
        self.init(type: .custom)
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(named: imageName), for: .normal)
        
        if let selectedNamed = selectedNamed {
            setImage(UIImage(named: selectedNamed), for: .selected)
        }
        
        if let title = title {
            setTitle(title, for: .normal)
        }
    }
    
    convenience init(named imageName: String, target: Any?, action: Selector) {
        self.init(named: imageName)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    convenience init(title: String, font: UIFont, color: UIColor) {
        self.init(type: .custom)
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        titleLabel?.font = font
    }
    
    convenience init(underlinedTitle title: String, font: UIFont, color: UIColor) {
        self.init(type: .custom)
        
        let attribute: [NSAttributedString.Key : Any] = [
            .font: font,
            .foregroundColor: color,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSAttributedString(string: title, attributes: attribute)
        
        translatesAutoresizingMaskIntoConstraints = false
        setAttributedTitle(attributedString, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 0.01, left: 0, bottom: 0.01, right: 0) // .zero를 사용할 경우 디폴트 인셋이 적용됨
    }
    
    
    func alignVertical(spacing: CGFloat = 6.0) {
        
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
            else { return }
        
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
    }
    
    func centerButtonAndImage(withSpacing spacing: CGFloat) {
        let inset = spacing / 2.0
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -inset, bottom: 0, right: inset)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: -inset)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    
}


extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        assert(alpha >= 0 && alpha <= 1, "Invalid alpha component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    static func random() -> UIColor {
        let r: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let g: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let b: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
    
}



extension UIImageView {
    
    convenience init(named imageName: String) {
        self.init(image: UIImage(named : imageName))
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func withContentMode(contentMode: UIView.ContentMode = .scaleAspectFill) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = contentMode
        return imageView
    }
    
}

extension UILabel {
    
    convenience init(text: String, font: UIFont?, color: UIColor?) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.font = font
        self.textColor = color
    }
    
    func textWidth() -> CGFloat {
        return UILabel.textWidth(label: self)
    }
    
    class func textWidth(label: UILabel) -> CGFloat {
        return textWidth(label: label, text: label.text!)
    }
    
    class func textWidth(label: UILabel, text: String) -> CGFloat {
        return textWidth(font: label.font, text: text)
    }
    
    class func textWidth(font: UIFont, text: String) -> CGFloat {
        let myText = text as NSString
        
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(labelSize.width)
    }
    
}



extension UINavigationController {
    
    open override var childForStatusBarStyle: UIViewController? {
        get {
            return self.topViewController
        }
    }
    
}



extension UIScrollView {
    //
    // Weird uitableview behaviour in iOS11. Cells scroll up with navigation push animation
    // https://stackoverflow.com/questions/45573829/weird-uitableview-behaviour-in-ios11-cells-scroll-up-with-navigation-push-anima
    //
    func adjustDifferencesBetweenOSVersions() {
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
        //        else {
        //            automaticallyAdjustsScrollViewInsets = false
        //        }
    }
    
    var atTop: Bool {
        return self.contentOffset.y <= 0
    }
    
    var atBottom: Bool {
        return self.contentOffset.y >= (self.contentSize.height - self.frame.size.height)
    }
    
}

extension UILabel{
    func addShadowToText(){
        self.layer.shadowColor = self.textColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.7
        
        self.layer.masksToBounds=false
        self.layer.shouldRasterize=true
    }
    func removeShadowFromText(){
        self.layer.shouldRasterize=false
    }
}

extension UIButton{
    @IBInspectable
    var imageContentModeAspectFit : Bool{
        get{
            return self.imageView?.contentMode  == ContentMode.scaleAspectFit
        }
        set(newValue){
            if newValue{
                self.imageView?.contentMode = ContentMode.scaleAspectFit
            }
        }
    }
}




extension UIViewController {
    
    func execute(after delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
    }
    
    func presentVC(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    func presentNavigationController(_ vc: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        presentVC(UINavigationController(rootViewController: vc), animated: animated, completion: completion)
    }
}

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            load(URLRequest(url: url))
        }
    }
}

extension Int{
    var toIndexPath : IndexPath{
        return IndexPath(row: self, section: 0)
    }
}

extension Dictionary where Key == String, Value == Any?{
    func filterNotNil() -> Dictionary<String,Any>{
        return self.compactMapValues{$0}
    }
}

extension String{
    var localized: String{
        return NSLocalizedString(self, comment: "")
    }
}



extension PrimitiveSequence{
    func addSchedulers() -> PrimitiveSequence{
        return self
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observeOn(MainScheduler.instance)
    }
}


