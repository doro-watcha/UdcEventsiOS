//
//  SketchImagesVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/28.
//
import Foundation
import UIKit
import DZNEmptyDataSet
import RxSwift
import PromiseKit

class SketchImagesVC : EXViewController {
    
    
    private var collectionView: UICollectionView!

    private var sketchImages: [UIImage] = []


    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        debugE(self)
        
        debugE("SketchImageVC")
        
        view.backgroundColor = .white
        
        initView()
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
        collectionView.showsHorizontalScrollIndicator = false 

        collectionView.bounces = false

        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(SketchImageItem.self, forCellWithReuseIdentifier: SketchImageItem.identifier)

        
        view.addSubviews(collectionView)
        let views = ["collectionView": collectionView!]
        


        view.addSubview(collectionView)
        
        view.addConstraints("H:|[collectionView]|", views: views)
        view.addConstraints("V:|[collectionView]|", views: views)
    
        
        
        
    }
    
    func setImages( images : [UIImage]) {


        self.sketchImages = images
        self.collectionView.reloadData()
        
        self.collectionView.scrollToItem(at: 0.toIndexPath, at: .top, animated: true)
        
        debugE(sketchImages)
    }
}

//
//
// MARK: -CollectionView DataSource
extension SketchImagesVC : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        debugE(sketchImages.count)
        return sketchImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        debugE("WHY")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SketchImageItem.identifier, for: indexPath) as! SketchImageItem
        debugE("BEFORe GUARD")
        guard let item = sketchImages[safe: indexPath.item] else { return cell }
        cell.image = item
            
        debugE("AFTER GUARD")



        return cell
    }


}

// MARK: -CollectionViewFlowLayout Delegate
extension SketchImagesVC : UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.height + 10 , height: view.frame.height)
    }

}

