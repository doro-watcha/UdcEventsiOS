//
//  MainEventVC.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation
import MaterialComponents.MaterialBottomSheet
import MaterialComponents.MDCFloatingButton
import RxSwift
import UIKit
import PromiseKit

class MainEventVC : EXViewController {
    
    
    private var isFetching = false
    private var isFetchCompleted = false
    
    private var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    
    
    private var mainEvents: [Event] = []
    var dataProvider: EventProvider?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        configureTPNavigationBar()
        
        debugE("MainEventVC")


        view.backgroundColor = .blue
        initView()
        fetchMainItems()
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
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(MainEventItemCell.self, forCellWithReuseIdentifier: MainEventItemCell.identifier)
        view.addSubview(collectionView)
        
        let views = ["collectionView": collectionView!]
        view.addConstraints("H:|[collectionView]|", views: views)
        view.addConstraints("V:|[collectionView]|", views: views)
        
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

        guard let dataProvider = dataProvider, isFetching == false else {
            if refresh { self.refreshControl.endRefreshing() }
            return
        }
        
        self.isFetching = true
        
        firstly {
            dataProvider.fetchItems(refresh: refresh)
        }.done { items in
            
            
            if refresh && !items.isEmpty {
            }
            self.mainEvents.append(contentsOf: items)
            
            debugE(items)

        }.ensure {
            
            
            self.isFetching = false
            self.isFetchCompleted = true
            self.collectionView.reloadData()
            
            if refresh {
                self.refreshControl.endRefreshing()
                self.collectionView.scrollToItem(at: 0.toIndexPath, at: .top, animated: true)
            }
        }.catch {_ in
            
            debugE("ERROR")
            
        }
    }
}


// MARK: -CollectionView DataSource
extension MainEventVC : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainEventItemCell.identifier, for: indexPath) as! MainEventItemCell
        guard let item = mainEvents[safe: indexPath.item] else { return cell }
        cell.event = item

        
 
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
extension MainEventVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    
}
