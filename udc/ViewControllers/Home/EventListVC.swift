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

class EventListVC: EXViewController {
//
//    // MARK: - Variablles
//    private let disposeBag = DisposeBag()
//
//
//
//    // MARK: - Status
//    private var isFetching = false
//    private var lastMaxId: Int = Int(Int32.max)
//
//    // MARK: - View
//    private lazy var tableView : UITableView = {
//        let v = UITableView(frame: .zero, style: UITableView.Style.plain)
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.dataSource = self
//        v.delegate = self
//        v.rowHeight = 36 + 6 + 6
//        let refreshControl = UIRefreshControl()
//        v.refreshControl = refreshControl
//        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
//        v.emptyDataSetSource = self
//        v.emptyDataSetDelegate = self
//
//        v.separatorStyle = .none
//        v.backgroundColor = .bgBlack
//        v.register(MusicTVCell.self, forCellReuseIdentifier: MusicTVCell.identifier)
//        return v
//    }()
//
//
//    // MARK: -ScrollViewRenderer
//    var isScrollEnabled = true
//    var contentScrollView: UIScrollView {
//        get {
//            return tableView
//        }
//    }
//
//    func scrollsToTop() {
//        tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 10, height: 10), animated: true)
//    }
//}
//
//// MARK: -Lifecycle
//extension MusicListVC{
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        initView()
//
//        fetchItems(isRefresh: true)
//
//        observeEvent()
//    }
//
//}
//
//// MARK: -Functions
//extension MusicListVC{
//    private func initView(){
//        view.addSubview(tableView)
//        let views = ["tableView" : tableView]
//        view.addConstraints("|[tableView]|", views: views)
//        view.addConstraints("V:|[tableView]|", views: views)
//    }
//
//    private func fetchItems(isRefresh: Bool){
//
//        guard let currentUserId = currentUser?.id else { return }
//
//        let maxId: Int
//        if isRefresh{
//            self.tableView.refreshControl?.endRefreshing()
//            maxId = Int(Int32.max)
//        }else{
//            maxId = musicBookmarks.map{$0.id}.min() ?? Int(Int32.max)
//        }
//
//        if lastMaxId <= maxId && !isRefresh{ return }
//        lastMaxId = maxId
//
//        isFetching = true
//        Music.fetchBookmaredItems(authorId: currentUserId, maxId: maxId).done{[unowned self] bookmarks in
//            if isRefresh{
//                self.musicBookmarks = bookmarks
//            }else{
//                self.musicBookmarks.append(contentsOf: bookmarks)
//            }
//            self.tableView.reloadData()
//        }.ensure{[unowned self] in
//            self.isFetching = false
//        }.catch{e in
//        }
//    }
//
//    private func observeEvent(){
//        Broadcast.MUSIC_BOOKMARK_UPDATED.asDriver(onErrorJustReturn: (false,-1)).drive(onNext: {[unowned self] isCreation, musicId in
//            if isCreation{
//                self.fetchItems(isRefresh: true)
//            }else{
//                guard let idx = self.musicBookmarks.firstIndex(where: {$0.music?.id == musicId}) else { return }
//                self.musicBookmarks.remove(at: idx)
//                self.tableView.deleteRows(at: [idx.toIndexPath], with: .fade)
//            }
//        }).disposed(by: disposeBag)
//    }
//}
//// MARK: -Actions
//extension EventListVC{
//    @objc private func onRefresh(){
//        fetchItems(isRefresh: true)
//    }
//}
//
//// MARK: -TableView Delegates
//extension EventListVC : UITableViewDelegate, UITableViewDataSource{
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if !isFetching {
//            fetchItems(isRefresh: false)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return musicBookmarks.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MusicTVCell.identifier) as! MusicTVCell
//        cell.music = musicBookmarks[indexPath.row].music!
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let music = self.musicBookmarks[safe: indexPath.row]?.music else { return }
//
//        Music.getItem(music.id).done{[unowned self] music in
//            guard let firstPart = music.parts[safe: 0] else { return }
//            self.presentMusicDetailPart(music: music, part: firstPart)
//        }.catch {_ in
//
//        }
//    }
//}
//// MARK: -EmptyDataSet Delegates
//extension MusicListVC : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
//
//    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
//        return CustomEmptyView(emptyIconName, emptyLabelText, emptyButtonText, emptyButtonTapHandler)
//    }
//
//    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
//        return true
//    }
//
//    @objc func emptyButtonTapped() {
//        emptyButtonTapHandler?()
//    }
//
//    func emptyDataSetWillAppear(_ scrollView: UIScrollView!) {
//        tableView.setContentOffset(.zero, animated: false)
//    }
}
