//
//  MainClassVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/22.
//

import Foundation
import UIKit
import PromiseKit

class MainClassVC: EXViewController {
    
    
    private var collectionView: UICollectionView!
    
    var sort : String = ""
    
    var dataProvider : DanceClassProvider?
    private var mainClasses: [DanceClass] = []
    private var isFetching = false
    private var isFetchCompleted = false
    
    private var currentPage = 0
    
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        debugE("Main Class VC")
        
        view.backgroundColor = .white
        
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

        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(MainClassItemCell.self, forCellWithReuseIdentifier: MainClassItemCell.identifier)

        
        view.addSubviews(collectionView)
        let views = ["collectionView": collectionView!]
        


        view.addSubview(collectionView)
        
        view.addConstraints("H:|[collectionView]|", views: views)
        view.addConstraints("V:|[collectionView]|", views: views)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true 
        
        
        
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
            
            debugE(items)
            self.mainClasses.append(contentsOf: items)
            
            debugE(self.mainClasses[0].mainImgUrl)
            debugE(self.mainClasses[1].mainImgUrl)

        }.ensure {
            
            
            self.isFetching = false
            self.isFetchCompleted = true
            self.collectionView.reloadData()
            
            debugE("RELOAD!")
            
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
extension MainClassVC : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        debugE("여기도 가즈아!")
        debugE(mainClasses.count)
        return mainClasses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        debugE("혺씨..?")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainClassItemCell.identifier, for: indexPath) as! MainClassItemCell
        guard let item = mainClasses[safe: indexPath.item] else { return cell }
        cell.danceClass = item
            
        debugE("여기 가즈아!!!")

 

        /**
        유저를 눌렀을 때 프로필로 이동
        */
//        cell.imageTapHandler = { [unowned self] in
//            self.navigateUserProfile(item.author!.id)
//        }
            
//        cell.imageTapHandler = { [unowned self] in
//            self.navigateEventDetail(event : item)
//        }


        return cell
    }
    
    
}

// MARK: -CollectionViewFlowLayout Delegate
extension MainClassVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}

extension MainClassVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) { // 컬렉션뷰를 스크롤하면 반복적으로 호출
        let width = scrollView.bounds.size.width // 너비 저장
        let x = scrollView.contentOffset.x + (width / 2.0) // 현재 스크롤한 x좌표 저장
        
        let newPage = Int(x / width)
        if currentPage != newPage {
            currentPage = newPage
        }
    }
}

