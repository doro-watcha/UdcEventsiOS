//
//  GenreClassVC.swift
//  udc
//
//  Created by 도로맥 on 2021/08/12.
//

import Foundation
import UIKit

import PromiseKit

class GenreClassVC: EXViewController {
    
    
    private var genreCollectionView : UICollectionView!
    
    var sort : String = ""
    
    var dataProvider : GenreProvider?
    private var genres: [Genre] = []
    private var isFetching = false
    private var isFetchCompleted = false
    
    private var currentPage = 0
    
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        debugE("Genre Class VC")
        
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
        
        
        genreCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        genreCollectionView.translatesAutoresizingMaskIntoConstraints = false
        genreCollectionView.backgroundColor = .clear
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self

        genreCollectionView.bounces = false

        genreCollectionView.alwaysBounceVertical = false
        genreCollectionView.alwaysBounceHorizontal = false
        genreCollectionView.showsVerticalScrollIndicator = false
        genreCollectionView.isPagingEnabled = true
        genreCollectionView.contentInsetAdjustmentBehavior = .never
        genreCollectionView.register(GenreItemCell.self, forCellWithReuseIdentifier: GenreItemCell.identifier)

        
        view.addSubviews(genreCollectionView)
        let views = ["genreCollectionView": genreCollectionView!]
        


        view.addSubview(genreCollectionView)
        
        view.addConstraints("H:|[genreCollectionView]|", views: views)
        view.addConstraints("V:|[genreCollectionView]|", views: views)
        
        genreCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        
        
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
            
    

        }.ensure {
            
            
            self.isFetching = false
            self.isFetchCompleted = true
            self.genreCollectionView.reloadData()
            
            
            if refresh {
                self.refreshControl.endRefreshing()
                self.genreCollectionView.scrollToItem(at: 0.toIndexPath, at: .top, animated: true)
            }
        }.catch {_ in
            
            debugE("ERROR")
            
        }
    }
}



// MARK: -CollectionView DataSource
extension GenreClassVC : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreItemCell.identifier, for: indexPath) as! GenreItemCell
        guard let item = genres[safe: indexPath.item] else { return cell }
        cell.genre = item
        

        return cell
    }
    
    
}

// MARK: -CollectionViewFlowLayout Delegate
extension GenreClassVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width / 4, height: view.frame.height)
    }
    
}

//extension GenreClassVC: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) { // 컬렉션뷰를 스크롤하면 반복적으로 호출
//        let width = scrollView.bounds.size.width // 너비 저장
//        let x = scrollView.contentOffset.x + (width / 2.0) // 현재 스크롤한 x좌표 저장
//
//        let newPage = Int(x / width)
//        if currentPage != newPage {
//            currentPage = newPage
//        }
//    }
//}
