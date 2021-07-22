//
//  MainClassVC.swift
//  udc
//
//  Created by 도로맥 on 2021/07/22.
//

import Foundation
import UIKit
import PromiseKit


final class MainClassVC : EXViewController {
    
    
    
    var dataProvider: DanceClassProvider?

    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private var items: [DanceClass] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugE("MainClassVC")
        


        tableView.adjustDifferencesBetweenOSVersions()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .bgBlack
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        tableView.estimatedRowHeight = 100
//        tableView.emptyDataSetSource = self
//        tableView.emptyDataSetDelegate = self
        tableView.register(SectionHeaderTVCell.self, forHeaderFooterViewReuseIdentifier: SectionHeaderTVCell.identifier)
        tableView.register(MainClassItemCell.self, forCellReuseIdentifier: MainClassItemCell.identifier)

        view.addSubview(tableView)
        
        let views = ["tableView": tableView]
        view.addConstraints("H:|[tableView]|", views: views)
        view.addConstraints("V:|[tableView]|", views: views)
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlActivated), for: .valueChanged)
        
        fetchItems()
    }
    
    
    private var isFetching = false
    private var isFetchCompleted = false

    func fetchItems(forRefresh refresh: Bool = false, showsProgress: Bool = false) {
//        guard let dataProvider = dataProvider, isFetching == false else {
//            if refresh { self.refreshControl.endRefreshing() }
//            return
//        }
//
//        self.isFetching = true
//
//        if showsProgress {
//            self.showProgress()
//        }
        
        let mockData : [DanceClass] = [ DanceClass.init(), DanceClass.init()]
        
        self.items.append (contentsOf : mockData)

//        firstly {
//            dataProvider.fetchItems(refresh: refresh)
//        }.done { items in
//            if refresh { self.items.removeAll() }
//            self.items.append(contentsOf: items)
//        }.ensure {
//
//            self.hideProgress()
//
//            if refresh {
//                self.refreshControl.endRefreshing()
////                self.tableView.contentOffset = CGPoint(x: 0, y: -self.tableView.contentInset.top)
////                self.tableView.layoutIfNeeded()
//            }
//
//            self.isFetching = false
//            self.isFetchCompleted = true
//            self.tableView.reloadData()
//
//        }.catch {e in
//        }
    }
    
    @objc func refreshControlActivated(sender: UIRefreshControl) {
        fetchItems(forRefresh: true)
    }
    

}



extension MainClassVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderTVCell.identifier) as! SectionHeaderTVCell
        headerView.titleLabel.text = Str.main_classes
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainClassItemCell.identifier, for: indexPath) as! MainClassItemCell
        
        guard let item = items[safe: indexPath.row] else {
            return cell
        }
        
//        cell.onPartTap = {[unowned self] part in
//            self.presentMusicDetailPart(music: item, part: part)
//        }
        
        cell.danceClass = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let reachedEnd = dataProvider?.reachedEnd {
            if reachedEnd == false && indexPath.row == self.items.count - 1 {
                fetchItems()
            }
        }
    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let danceClass = items[safe: indexPath.item], let firstPart = music.parts.first else { return }
//        presentMusicDetailPart(music: music, part: firstPart)
//    }
//
}

