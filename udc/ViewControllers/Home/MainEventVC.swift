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
        fetchMainItems()
    }

    func fetchMainItems(forRefresh refresh: Bool = false) {

        guard let dataProvider = dataProvider, isFetching == false else {
            debugE("FUCKMAN")
            if refresh { self.refreshControl.endRefreshing() }
            return
        }
        
        self.isFetching = true
        
        debugE("TRY")
        firstly {
            dataProvider.fetchItems(refresh: refresh)
        }.done { items in
            
            debugE("GOOD")
            
            if refresh && !items.isEmpty {
            }
            self.mainEvents.append(contentsOf: items)
            
            debugE(items)

        }.ensure {
            
            debugE("PELAESE")
            
            self.isFetching = false
            self.isFetchCompleted = true
            //self.collectionView.reloadData()
            
            if refresh {
                self.refreshControl.endRefreshing()
                self.collectionView.scrollToItem(at: 0.toIndexPath, at: .top, animated: true)
            }
        }.catch {_ in
            
            debugE("ERROR")
            
        }
    }
}
