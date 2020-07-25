//
//  SearchViewController.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var mTableView: UITableView!
     
    var mSearchController: UISearchController!
    
    // 필터 적용 여부
    var mIsFiltering:Bool = false
    
    // 로컬에 저장 된 최근 검색어 목록
    var mRecentSearchList:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
    }

    
    // MARK:- set ui
    func setUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setSearchBar()
        setTableView()
    }
    
    func setSearchBar() {
        // init UISearchController
        mSearchController = UISearchController(searchResultsController: nil)
        mSearchController.dimsBackgroundDuringPresentation = false

        // set searchBar
        mSearchController.searchBar.sizeToFit()
        mSearchController.searchBar.delegate = self
        mSearchController.searchBar.placeholder = "App Store"
    }
    
    func setTableView() {
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.tableHeaderView = mSearchController.searchBar
        
        mTableView.separatorStyle = .none
        
        mTableView.register(UINib(nibName: "RecentSearchCell", bundle: nil), forCellReuseIdentifier: "RecentSearchCell")
        mTableView.register(UINib(nibName: "RecentSearchHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RecentSearchHeaderView")
        
        setTableViewData(recentSearchList: Common.getRecentSearchList())
    }
    
    
    
    
    // MARK:- functions
    func setTableViewData(recentSearchList:[String] = []) {
        mRecentSearchList = recentSearchList
        LOG("set data : \(mRecentSearchList)")
        
        mTableView.reloadData()
    }
    
    func filterRecentSearch(text: String) {
        
        let searchList = Common.getRecentSearchList()
        
        let filterList = text.isEmpty ? searchList : searchList.filter({
            (keyword: String) -> Bool in
            return keyword.range(of: text, options: .caseInsensitive) != nil
        })

        LOG("-> filter : \(filterList)")

        setTableViewData(recentSearchList: filterList)
    }
}




// MARK: - extension UITableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    // row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mRecentSearchList.count
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:RecentSearchCell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchCell") as! RecentSearchCell
        cell.setData(text: mRecentSearchList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    // header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !mIsFiltering {
            let view:RecentSearchHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RecentSearchHeaderView") as! RecentSearchHeaderView
            return view
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !mIsFiltering {
            return 60
        }
        return 0
    }
    
    // select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
    }
}




// MARK: - extension UISearchController
extension SearchViewController: UISearchBarDelegate {

    // changed
    func searchBar(_ searchBar: UISearchBar, textDidChange: String) {
        guard let searchText = searchBar.text else { return }
        filterRecentSearch(text: searchText)
    }
    
    // begin editing
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        mIsFiltering = true
        filterRecentSearch(text: "")
    }
    
    // end editing
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        mIsFiltering = false
        filterRecentSearch(text: "")
    }
    
    
    // MARK:- button event
    // search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
                        
        var searchList:[String] = Common.getRecentSearchList()
        
        LOG("\(searchList)")
        
        // 검색어 없는 경우 추가
        if !searchList.contains(searchText) {
            // 0번째 추가
            searchList.insert(searchText, at: 0)
        }
        
        // 검색어 저장
        Common.setRecentSearchList(value: searchList)
        
        LOG("->\(Common.getRecentSearchList())")
    }
    
    // cancel
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterRecentSearch(text: "")
    }

}
