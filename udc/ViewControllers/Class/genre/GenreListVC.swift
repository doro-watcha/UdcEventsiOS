//
//  GenreClassVC.swift
//  udc
//
//  Created by 도로맥 on 2021/08/12.
//

import Foundation
import UIKit

import PromiseKit

class GenreListVC: EXViewController {
    
    
    private var collectionView : UICollectionView!
    
    var sort : String = ""
    
    var dataProvider : GenreProvider?
    private var genres: [Genre] = []
    private var isFetching = false
    private var isFetchCompleted = false
    
    private var currentPage = 0
    
    
    private let refreshControl = UIRefreshControl()
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        debugE("Genre List VC")
        
        view.backgroundColor = .white
        
   
        fetchItems()
    }
    
    /** Layout */
    private func initView(){
        

     
    
        
        
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
            self.genres.append(contentsOf: items)
            self.initGenreClass()
            

        }.ensure {
            
            
            self.isFetching = false
            self.isFetchCompleted = true
       //     self.collectionView.reloadData()
            
            debugE("RELOAD!")
            
            if refresh {
                self.refreshControl.endRefreshing()
                self.collectionView.scrollToItem(at: 0.toIndexPath, at: .top, animated: true)
            }
        }.catch {_ in
            
            debugE("ERROR")
            
        }
    }
    
    private func initGenreClass() {
        
        
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
        collectionView.register(GenreItemCell.self, forCellWithReuseIdentifier: GenreItemCell.identifier)

        
        view.addSubviews(collectionView)

        

        let genreClassVC = GenreClassVC()
        
        genreClassVC.dataProvider = GenreClassProvider.newInstance()
        
        addChild(genreClassVC)
        genreClassVC.view.translatesAutoresizingMaskIntoConstraints = false
        genreClassVC.didMove(toParent: self)

        let views = [ "genreClassView" : genreClassVC.view!,"collectionView": collectionView!]
        
        
        
        view.addSubviews(collectionView, genreClassVC.view!)
        
        view.addConstraints("H:|[collectionView]|", views: views)
        view.addConstraints("H:|[genreClassView]|",views: views)
        view.addConstraints("V:[collectionView]-[genreClassView]", views: views)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        genreClassVC.view.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true 
        
        
    }
}



// MARK: -CollectionView DataSource
extension GenreListVC : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreItemCell.identifier, for: indexPath) as! GenreItemCell
        guard let item = genres[safe: indexPath.item] else { return cell }
        cell.genre = item
            

 

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
extension GenreListVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}

extension GenreListVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) { // 컬렉션뷰를 스크롤하면 반복적으로 호출
        let width = scrollView.bounds.size.width // 너비 저장
        let x = scrollView.contentOffset.x + (width / 2.0) // 현재 스크롤한 x좌표 저장
        
        let newPage = Int(x / width)
        if currentPage != newPage {
            currentPage = newPage
        }
    }
}
