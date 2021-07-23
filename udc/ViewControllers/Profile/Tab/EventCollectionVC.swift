//
//  EventCollectionVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/23.
//


import UIKit
import DZNEmptyDataSet
import PromiseKit
import RxSwift
import SPPermissions


class EventCollectionVC : EXViewController, ScrollViewRenderer {

    // MARK: - Data Provider
    var dataProvider: EventProvider?
    
    // MARK: - Empty Data Set Parameters
    var emptyIconName = "cameraBig"
    var emptyLabelText = ""
    var emptyButtonText = ""
    var emptyButtonTapHandler: (() -> Void)?
    
    // MARK: - Variables
    private let disposeBag = DisposeBag()

    private var items: [Event] = []
    
    private var isFetching = false
    private var isFetchCompleted = false
    
    // MARK: - View
    private var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    
    // MARK: - ScrollView Renderer
    
    var isScrollEnabled = true
    var contentScrollView: UIScrollView {
        get {
            return collectionView
        }
    }
    
    func scrollsToTop() {
        collectionView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 10, height: 10), animated: true)
    }
    
}

// MARK: -Functions
extension EventCollectionVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCustomNavigationBar()
        title = "EventCollection"
        view.backgroundColor = .bgBlack
        
        let itemWidth = (UIScreen.main.bounds.width - (2 * 2)) / 3
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .bg2
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(EventCVCell.self, forCellWithReuseIdentifier: EventCVCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .always
        
        collectionView.refreshControl = refreshControl

        view.addSubview(collectionView)
        
        
        let views = ["collectionView": collectionView!]
        view.addConstraints("H:|[collectionView]|", views: views)
        view.addConstraints("V:|[collectionView]|", views: views)
        
        fetchItems()
        
    
    }
    
    func fetchItems(forRefresh refresh: Bool = false) {
        guard let dataProvider = dataProvider, isFetching == false else {
            if refresh { self.refreshControl.endRefreshing() }
            return
        }
        
        self.isFetching = true
        
        
    }
   

    

  
}

// MARK: -CollectionView Delegates
extension EventCollectionVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCVCell.identifier, for: indexPath) as! EventCVCell
       
        cell.contentView.hero.id = "\(indexPath.row)"
        
        
        /**
        만약 현재 보여주려는 cell 이 retry 아이템들이라면
        */
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let reachedEnd = dataProvider?.reachedEnd {
            if reachedEnd == false {
                fetchItems()
            }
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let video = self.items[safe: indexPath.row - pendingItems.count] else { return }
//        presentVideoDetail(video: video, heroId: "\(indexPath.row)")
//    }
}


