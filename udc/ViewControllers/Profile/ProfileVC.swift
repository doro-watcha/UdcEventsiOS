//
//  ProfileVC.swift
//  udc
//
//  Created by 도로맥 on 2021/05/26.
//


import UIKit
import PromiseKit
import RxSwift


final class ProfileVC: EXViewController, UIGestureRecognizerDelegate, ScrollViewRenderer {

    private let disposeBag = DisposeBag()
    
    var user: User!
    var segmentIndex: Int = 0

    private let headerVC = ProfileHeaderVC()
    private var currentVC: UIViewController?

    private var headerViewHeightConstraint: NSLayoutConstraint!
    private var panStartLocation: CGPoint?
    private var scrollAnchor: CGFloat = 0
    private var prevHeaderHeight: CGFloat = 0
    private var currentHeaderHeight: CGFloat = 0 {
        didSet {
            headerViewHeightConstraint.constant = currentHeaderHeight
            headerVC.currentHeight = currentHeaderHeight
            navigationItem.title = (currentHeaderHeight == headerVC.minHeight) ? "panic" : ""
        }
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTPNavigationBar()
        
        user = user ?? AppModel.shared.currentUser ?? User()
        headerVC.user = user

        addChild(headerVC)
        headerVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerVC.view)
        headerVC.didMove(toParent: self)

        let views = ["headerView": headerVC.view!]
        view.addConstraints("H:|[headerView]|", views: views)
        view.addConstraints("V:|[headerView]", views: views)

        headerViewHeightConstraint = headerVC.view!.heightAnchor.constraint(equalToConstant: headerVC.maxHeight)
        headerViewHeightConstraint.priority = .defaultLow
        headerViewHeightConstraint.isActive =  true
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        
        currentHeaderHeight = headerVC.maxHeight
        
        headerVC.maxHeightChangeHandler = { [unowned self] height, animated in
            self.currentHeaderHeight = height
            
            if animated {
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }

        headerVC.segmentView.autoSelect = false
        headerVC.segmentView.selectedIndex = segmentIndex
        headerVC.segmentView.itemSelectionHandler = { [unowned self] index in
            self.headerVC.segmentView.selectedIndex = index
            self.switchVCForIndex(index)
        }

        switchVCForIndex(segmentIndex)
        
        observeEvent()
    }
    
    
    // MARK: -  UIGestureRecognizerDelegate

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let rendererVC = currentVC as? ScrollViewRenderer else { return false }
        return (otherGestureRecognizer.view == rendererVC.contentScrollView)
    }
    
    @objc func panGestureRecognized(gesture: UIPanGestureRecognizer) {
        guard var rendererVC = currentVC as? ScrollViewRenderer else { return }
        
        if gesture.state == .began {
            panStartLocation = gesture.location(in: gesture.view)
            prevHeaderHeight = headerViewHeightConstraint.constant
            scrollAnchor = 0
        }
        else if gesture.state == .changed {
            guard let panStartLocation = panStartLocation else {
                return
            }
            
            let currentLocation = gesture.location(in: gesture.view)
            var dy = currentLocation.y - panStartLocation.y
            
            if scrollAnchor > 0 {
                dy -= scrollAnchor
            }
            else {
                // 헤더뷰가 최소사이즈인 상태에서 밑으로 내리는 경우
                if (dy > 0 && headerViewHeightConstraint.constant <= headerVC.minHeight) {
                    
                    // 컨텐츠가 스크롤된 상태에서 아래로 내리는 경우 무시
                    if (dy > 0 && rendererVC.contentScrollView.contentOffset.y > 0) {
                        return
                    }
                    
                    scrollAnchor = dy
                    dy = 0
                }
            }
            
            var headerHeight = prevHeaderHeight + dy
            headerHeight = min(headerHeight, headerVC.maxHeight)
            headerHeight = max(headerHeight, headerVC.minHeight)
            currentHeaderHeight = headerHeight
            
            rendererVC.isScrollEnabled = (headerHeight <= headerVC.minHeight || headerHeight >= headerVC.maxHeight)
        }
        else if gesture.state == .cancelled || gesture.state == .ended {
            
            let velocity = gesture.velocity(in: gesture.view)
            let duration: CGFloat = 0.5
            let distance: CGFloat = (velocity.y == 0) ? 1 : velocity.y * duration // velocity가 0일때 distance가 0이 되지 않도록 보정
            let height = (velocity.y > 0) ? headerVC.maxHeight : headerVC.minHeight
            
            if (velocity.y > 0 && rendererVC.contentScrollView.contentOffset.y > 0) {
                return;
            }
            
            currentHeaderHeight = height
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: velocity.y / distance,
                           options: [.beginFromCurrentState, .allowUserInteraction],
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
            
            rendererVC.isScrollEnabled = true
        }
    }
    
    
    // MARK: -  ScrollViewRenderer
    
    var isScrollEnabled = true
    var contentScrollView: UIScrollView {
        get {
            guard let rendererVC = currentVC as? ScrollViewRenderer else { return tab1VC.contentScrollView }
            return rendererVC.contentScrollView
        }
    }
    
    func scrollsToTop() {
        guard let rendererVC = currentVC as? ScrollViewRenderer else { return }
        rendererVC.scrollsToTop()
        
        self.currentHeaderHeight = self.headerVC.maxHeight
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    
    
    
    // MARK: -  Tabs
    
    /**
    탭1 - 내가 업로드한 행사
    */
    lazy private var tab1VC: EventCollectionVC = {
        let vc = EventCollectionVC()
//        vc.dataProvider = AllVideoProvider.newInstance(authorId: user.id, currentUserIdForBlocking: self.currentUser?.id)
//
//        /// If VC is used as my page
//        if self.user.id == self.currentUser?.id{
//            vc.showPendingItems = true
//            vc.emptyLabelText = Str.profile_tab1_empty
//        }else{
//            vc.showPendingItems = false
//            vc.emptyLabelText = Str.profile_tab1_other_empty
//        }
//        vc.emptyButtonText = Str.profile_tab1_empty_button
        return vc
    }()
    
    /**
    탭2 - 승인 대기중인 행사
    */
    lazy private var tab2VC: EventCollectionVC = {
        let vc = EventCollectionVC()
//        vc.emptyIconName = "archiveBig"
//        vc.emptyLabelText = Str.profile_tab2_empty
//        vc.emptyButtonText = Str.profile_tab2_empty_button
        return vc
    }()
    


    func vcForIndex(_ index:Int) -> UIViewController? {
        switch index {
        case 0: return tab1VC
        case 1: return tab2VC

        default: return nil
        }
    }
    
    func switchVCForIndex(_ index:Int) {
        if let vc = currentVC {
            removeChildVC(vc)
        }
        
        if let vc = vcForIndex(index) {
            addChildVC(vc)
            currentVC = vc
        }
    }
    
    // MARK: - Function
    
    func addChildVC(_ vc: UIViewController) {
        addChild(vc)
        view.addSubview(vc.view)
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["childView": vc.view!, "headerView": headerVC.view!]
        view.addConstraints("H:|[childView]|", views: views)
        view.addConstraints("V:[headerView][childView]|", views: views)
        
        vc.didMove(toParent: self)
    }
    
    func removeChildVC(_ vc: UIViewController) {
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    
    private func observeEvent(){

    }

}
