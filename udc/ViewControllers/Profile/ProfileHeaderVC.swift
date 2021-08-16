//
//  ProfileHeaderVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/23.
//

import Foundation



import UIKit
import PromiseKit
import Hero

final class ProfileHeaderVC: EXViewController {
    
    var user: User? {
        didSet {
            guard let user = user else { return }
            headerView.user = user
        }
    }
    
    
    // params (height, animated)
    var maxHeightChangeHandler: ((CGFloat, Bool) -> Void)?
    
    var minHeight: CGFloat {
        get {
            return LayoutHelper.shared.safeAreaInsets.top
                + 44 // navBar
                + 44 // segmentView
        }
    }
    
    var maxHeight: CGFloat {
        get {
            return headerViewHeight
                + 44  // segmentView
        }
    }
    
    var currentHeight: CGFloat = 0 {
        didSet {
            let percentage = (currentHeight - minHeight) * 100 / (maxHeight - minHeight)
            navBarCover.alpha = 1.0 - (percentage / 100)
        }
    }
    
    var segmentView: SegmentView!
    private let navBarCover = UIView(bgColor: .surfaceBlack)
    private let headerView = ProfileHeaderView()
    private var headerViewHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Hero Setting
        self.hero.isEnabled = true
        headerView.hero.id = "HeaderView"
        
        view.backgroundColor = .surfaceBlack
        headerViewHeight = LayoutHelper.shared.adjustedValueForTemplateValue(130 + 88)
//        headerView.aboutTapHandler = { [unowned self] in
//            self.presentAbout(self.user!)
//        }
        headerView.settingTapHandler = { [unowned self] in
            self.presentSetting()
        }
//        
        segmentView = SegmentView(titles: ["collection", "pending"])
        segmentView.backgroundColor = .surfaceBlack
        segmentView.topLine.isHidden = true
        navBarCover.alpha = 0
        
        
        view.addSubview(headerView)
        view.addSubview(segmentView)
        view.addSubview(navBarCover)
        
        
        let views = ["headerView": headerView, "segmentView": segmentView!, "navBarCover": navBarCover]
        view.addConstraints("H:|[headerView]|", views: views)
        headerView.heightAnchor.constraint(equalToConstant: headerViewHeight).isActive = true
        
        view.addConstraints("H:|[segmentView]|", views: views)
        view.addConstraints("V:[headerView][segmentView(44)]|", views: views)
        
        view.addConstraints("H:|[navBarCover]|", views: views)
        view.addConstraints("V:|[navBarCover]", views: views)
        navBarCover.heightAnchor.constraint(equalToConstant: LayoutHelper.shared.safeAreaInsets.top + 44).isActive = true
        
        maxHeightChangeHandler?(maxHeight, false)
        
        
    }

    
}
