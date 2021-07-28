//
//  EventVC.swift
//  udc
//
//  Created by 도로맥 on 2021/06/30.
//

import Foundation
import UIKit
import DZNEmptyDataSet
import RxSwift
import PromiseKit

class EventListVC: EXViewController {
    
    
    private var collectionView: UICollectionView!
    
    var sort : String = ""
    
    var dataProvider : EventProvider?
    private var eventList: [Event] = []
    private var isFetching = false
    private var isFetchCompleted = false
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        debugE(self)
        
        debugE("EventListVc")
        
        view.backgroundColor = .black
        
        initView()
        fetchItems()
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

        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(EventItemCell.self, forCellWithReuseIdentifier: EventItemCell.identifier)

        
        view.addSubviews(collectionView)
        let views = ["collectionView": collectionView!]
        


        view.addSubview(collectionView)
        
        view.addConstraints("H:|[collectionView]|", views: views)
        view.addConstraints("V:|[collectionView]|", views: views)
        
        
        
    }
    
    private func fetchItems(forRefresh refresh: Bool = false) {
    
    
        guard let dataProvider = dataProvider, isFetching == false else {
            if refresh { self.refreshControl.endRefreshing() }
            return
        }
        
        self.isFetching = true
        
        firstly {
            dataProvider.fetchItems(refresh: refresh)
        }.done { items in
            
            self.eventList.append(contentsOf: items)

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
extension EventListVC : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        debugE("여기도 가즈아!")
        debugE(eventList.count)
        return eventList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventItemCell.identifier, for: indexPath) as! EventItemCell
        guard let item = eventList[safe: indexPath.item] else { return cell }
        cell.event = item
            
        debugE("여기 가즈아!!!")

 

        /**
        유저를 눌렀을 때 프로필로 이동
        */
//        cell.imageTapHandler = { [unowned self] in
//            self.navigateUserProfile(item.author!.id)
//        }
            
        cell.imageTapHandler = { [unowned self] in
            self.navigateEventDetail(event : item)
        }


        return cell
    }
    
    private func navigateEventDetail(event : Event ){
        
        self.presetEventDetail(event: event)
    }
    
}

// MARK: -CollectionViewFlowLayout Delegate
extension EventListVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width / 2, height: view.frame.height)
    }
    
}

