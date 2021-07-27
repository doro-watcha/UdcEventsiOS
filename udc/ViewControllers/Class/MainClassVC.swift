//
//  MainClassVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/22.
//

import Foundation
import UIKit
import PromiseKit


class MainClassVC : EXViewController {
    
    
    private var isFetching = false
    private var isFetchCompleted = false
    
    private var pager: UIPageControl!
    
    private var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    private var currentPage = 0
    
    
    private var mainClasses: [DanceClass] = []
    
    private lazy var blurImageView : EXImageView = {
       let v = EXImageView()
        let blurEffect = UIBlurEffect(style : .extraLight)
        let visualEffectView = UIVisualEffectView(effect : blurEffect)
        visualEffectView.frame = v.frame
        v.addSubview(visualEffectView)
        v.contentMode = .center
        
        return v
    }()
    
    var dataProvider: EventProvider?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initView()
        fetchMainItems()
    }
    
    private func pageChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    /** Layout */
    private func initView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.bounces = false


        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(MainClassItemCell.self, forCellWithReuseIdentifier: MainClassItemCell.identifier)

        
        view.addSubviews(collectionView, blurImageView)
        let views = ["collectionView": collectionView!, "blurImageView" : blurImageView]
        
        view.addConstraints("H:|[blurImageView]|", views: views)

        view.addSubview(collectionView)
        
        view.addConstraints("H:|[collectionView]|", views: views)
        view.addConstraints("V:|[collectionView]|", views: views)
        
        blurImageView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        
        view.bringSubviewToFront(collectionView)
        

        
        
        
        collectionView.refreshControl = refreshControl
//        refreshControl.addTarget(self, action: #selector(refreshControlActivated), for: .valueChanged)
//
//        if isUsedDetailScreen{
//            collectionView.isScrollEnabled = false
//
//            self.videos = [detailScreenVideo!]
//            self.updateCurrentVideoInformation()
//            self.collectionView.reloadData()
//        }
        
        
    }
    

    func fetchMainItems(forRefresh refresh: Bool = false) {
//
//        guard let dataProvider = dataProvider, isFetching == false else {
//            if refresh { self.refreshControl.endRefreshing() }
//            return
//        }
//
//        self.isFetching = true
//
//        firstly {
//            dataProvider.fetchItems(refresh: refresh)
//        }.done { items in
//
//
//            if refresh && !items.isEmpty {
//            }
//            self.mainClasses.append(contentsOf: items)
//            self.blurImageView.imageUrl = URL(string : items[0].posterImgUrl)
//
//            debugE(items)
//
//        }.ensure {
//
//
//            self.isFetching = false
//            self.isFetchCompleted = true
//            self.collectionView.reloadData()
//
//            if refresh {
//                self.refreshControl.endRefreshing()
//                self.collectionView.scrollToItem(at: 0.toIndexPath, at: .top, animated: true)
//            }
//        }.catch {_ in
//
//            debugE("ERROR")
//
//        }
    }
}


// MARK: -CollectionView DataSource
extension MainClassVC : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        debugE(section)
        return mainClasses.count
    }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainClassItemCell.identifier, for: indexPath) as! MainClassItemCell
        guard let item = mainClasses[safe: indexPath.item] else { return cell }
        cell.danceClass = item

 
//
//        /**
//        유저를 눌렀을 때 프로필로 이동
//        */
//        cell.userTapHandler = { [unowned self] in
//            self.navigateUserProfile(item.author!.id)
//        }
//
//
        return cell
    }
    
    
    
    
}

// MARK: -CollectionViewFlowLayout Delegate
extension MainClassVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    
}
