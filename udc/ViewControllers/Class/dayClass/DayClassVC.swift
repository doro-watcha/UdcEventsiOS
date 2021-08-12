//
//  DayClassVC.swift
//  udc
//
//  Created by 도로맥 on 2021/08/12.
//

import Foundation
import UIKit

class DayClassVC : EXViewController {
    
    private var collectionView : UICollectionView!
    
    private var dateList : [ClassDate] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todayDay = Calendar.current.dateComponents([.day], from: Date())
        debugE(todayDay)
        
        //dateList = [ClassDate.init(day: <#T##Int#>, date: <#T##String#>, dateInt: <#T##Int#>)]
    }
    
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
}

// MARK: -CollectionView DataSource
extension DayClassVC : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateItemCell.identifier, for: indexPath) as! DateItemCell
        guard let item = dateList[safe: indexPath.item] else { return cell }
        cell.classDate = item


        return cell
    }
    
    
}

// MARK: -CollectionViewFlowLayout Delegate
extension DayClassVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
