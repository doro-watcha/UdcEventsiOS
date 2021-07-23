//
//  Segment.swift
//  udc
//
//  Created by 도로맥 on 2021/07/23.
//

import Foundation
import UIKit

final class SegmentView: UIView {
    
    enum Alignment {
        case center
        case left
        case right
    }
    
    struct Settings {
        var alignment: SegmentView.Alignment = .center
        var font: UIFont = .bold13
        var selectedFont: UIFont = .bold13
        var color: UIColor = .gray
        var selectedColor: UIColor = .white
    }
    
    // 항목선택시 자동으로 선택처리할지 여부
    var autoSelect = true
    
    var selectedIndex = 0 {
        didSet {
            guard selectedIndex >= 0 || selectedIndex < buttons.count else {
                return
            }
            
            items[oldValue].isSelected = false
            items[selectedIndex].isSelected = true
        }
    }
    
    var itemSelectionHandler: ((Int) -> Void)?
    
    let topLine = UIView(bgColor: .black)
    
    private var buttons: [UIButton]!
    private var items: [SegmentItemView]!
    private var settings: SegmentView.Settings!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(titles: [String], settings: SegmentView.Settings = Settings()) {
        super.init(frame: .zero)
        self.settings = settings
        buttons = titles.map { makeButton(withTitle: $0) }
        setupUI(withButtons: buttons)
    }
    
    init(imageNames: [String], selectedImageNames: [String]? = nil) {
        super.init(frame: .zero)
        self.settings = Settings()
        buttons = imageNames.map { makeButton(withImageName: $0) }

        if let selectedImageNames = selectedImageNames {
            if selectedImageNames.count == buttons.count {
                for i in 0..<buttons.count {
                    buttons[i].setImage(UIImage(named: selectedImageNames[i]), for: .selected)
                }
            }
        }

        setupUI(withButtons: buttons)
    }
    
    private func makeButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .custom)
//        button.setTitle(title, for: .normal)
//        button.setTitleColor(settings.color, for: .normal)
//        button.setTitleColor(settings.selectedColor, for: .selected)
//        button.titleLabel?.font = settings.font
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)

        let normalTitle = NSMutableAttributedString(string: title)
        normalTitle.addAttribute(.font, value: settings.font, range: NSRange(location: 0, length: title.count))
        normalTitle.addAttribute(.foregroundColor, value: settings.color, range: NSRange(location: 0, length: title.count))

        let selectedTitle = NSMutableAttributedString(string: title)
        selectedTitle.addAttribute(.font, value: settings.selectedFont, range: NSRange(location: 0, length: title.count))
        selectedTitle.addAttribute(.foregroundColor, value: settings.selectedColor, range: NSRange(location: 0, length: title.count))

        button.setAttributedTitle(normalTitle, for: .normal)
        button.setAttributedTitle(selectedTitle, for: .selected)

        return button
    }
    
    
    private func makeButton(withImageName imageName: String) -> UIButton {
        let button = UIButton(named: imageName)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }
    
    private func setupUI(withButtons buttons: [UIButton]) {
        translatesAutoresizingMaskIntoConstraints = false

        items = buttons.map { SegmentItemView(withButton: $0) }
        
        let stack = UIStackView(arrangedSubviews: items)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        
        addSubview(topLine)
        addSubview(stack)
        
        let views = ["topLine": topLine, "stack": stack]
        addConstraints("H:|[topLine]|", views: views)
        addConstraints("H:|[stack]|", views: views)
        addConstraints("V:|[topLine(1)][stack]-0@1000-|", views: views)
        
        if (settings.alignment == .right) {
            stack.spacing = 15
            addConstraints("H:|-(>=10@750)-[stack]-5-|", views: views)
        }
        else if (settings.alignment == .left) {
            stack.spacing = 15
            addConstraints("H:|-20-[stack]-(>=10@750)-|", views: views)
        }
        else {
            stack.distribution = .fillEqually
            addConstraints("H:|[stack]|", views: views)
        }
    }
    

    @objc private func buttonTapped(sender:UIButton) {
        if let index = buttons.firstIndex(of: sender) {
            if autoSelect {
                selectedIndex = index
            }
            itemSelectionHandler?(index)
        }
    }
    
    
    
    //
    // 알림 탭 > 네비게이션에 SegmentView를 삽입시 (navigationItem.titleView = segmentView)
    // iOS 11에서 full width로 나타나지 않는 이슈 수정
    //
    // iOS 11 navigationItem.titleView Width Not Set
    // https://stackoverflow.com/questions/44932084/ios-11-navigationitem-titleview-width-not-set
    // As an explanation: the titleView is now laid out with Auto Layout. Since it looks for the intrinsicContentSize, this is what worked.
    //
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
}





final class SegmentItemView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var button: UIButton!
    var bottomLine = UIView(bgColor: UIColor(rgb: 0x5A95DF))
    
    var isSelected: Bool = false {
        didSet {
            button.isSelected = isSelected
            bottomLine.isHidden = !isSelected
        }
    }
    
    init(withButton button: UIButton) {
        super.init(frame: .zero)
        self.button = button
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        button.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.isHidden = true

        addSubview(button)
        addSubview(bottomLine)
        
        button.activateCenterConstraints(to: self)
        
        let views = ["bottomLine": bottomLine]
        addConstraints("H:|-15-[bottomLine]-15-|", views: views)
        addConstraints("V:[bottomLine(3)]|", views: views)
    }
    
    override var intrinsicContentSize: CGSize {
        return button.intrinsicContentSize
    }
    
}
