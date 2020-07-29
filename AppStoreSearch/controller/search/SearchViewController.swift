//
//  SearchViewController.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

enum SEARCH_SECTION:Int {
    case RECENT_SEARCH = 0
    case FILTER
    case SEARCH_RESULT
    case NONE
}

protocol SearchViewProtocol {
    func openClick(id: Int)
}

class SearchViewController: UIViewController, SearchViewProtocol {
    
    
    @IBOutlet weak var mTableView: UITableView!
     
    var mSearchController: UISearchController!
    
    // 필터 적용 여부
    var mIsFiltering:Bool = false
    
    // 검색 결과 노출 여부
    var mIsShowResult:Bool = false
    
    // 로컬에 저장 된 최근 검색어 목록
    var mRecentSearchList:[String] = []
    
    // api 로 받은 검색 결과
    var mSearchResults: [Result] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        definesPresentationContext = true    // 상세 화면 서치바 안보이게 설정
        
        setUI()
    }

    
    // MARK:- set ui
    func setUI() {
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
        
        mTableView.rowHeight = UITableView.automaticDimension
        mTableView.estimatedRowHeight = 200
        
        mTableView.register(UINib(nibName: "RecentSearchHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RecentSearchHeaderView")
        mTableView.register(UINib(nibName: "RecentSearchCell", bundle: nil), forCellReuseIdentifier: "RecentSearchCell")
        mTableView.register(UINib(nibName: "RecentSearchFilterCell", bundle: nil), forCellReuseIdentifier: "RecentSearchFilterCell")
        mTableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
        
        setTableViewData(recentSearchList: Common.getRecentSearchList())
        
    }
    
    
    
    
    // MARK:- functions
    func showDetailViewController(id: Int) {
        mSearchController.searchBar.resignFirstResponder()

        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchDetailViewController") as! SearchDetailViewController
        detailVC.mId = id
//        detailVC.hidesBottomBarWhenPushed = true    // 상세 화면 탭바 안보이게 설정
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func setTableViewData(recentSearchList: [String]? = nil, results: [Result]? = nil) {
        mIsShowResult = (recentSearchList != nil) ? false : true
    
        if mIsShowResult { // 검색 결과
            if let resultData = results {
                mSearchResults = resultData
                LOG("set > result data : \(resultData)")
            }
            
        } else { // 최근 검색어
            if let recentSearchData = recentSearchList {
                mRecentSearchList = recentSearchData
                LOG("set > recent search data : \(recentSearchData)")
            }
        }

        mTableView.reloadData()
    }
    
    // 최근 검색어 필터
    func filterRecentSearch(text: String) {
        mIsFiltering = text.isEmpty ? false : true
        
        let searchList = Common.getRecentSearchList()
        
        let filterList = text.isEmpty ? searchList : searchList.filter({
            (keyword: String) -> Bool in
            return keyword.range(of: text, options: .caseInsensitive) != nil
        })

        LOG("-> filter : \(filterList)")

        setTableViewData(recentSearchList: filterList)
    }
    
    // 검색어 클릭
    func clickSearchItem(text: String) {
        LOG("click : \(text)")
        
        // 검색어 서치바에 입력, 포커스
        mSearchController.searchBar.text = text
        mSearchController.searchBar.becomeFirstResponder()
        
        // 검색 전 빈 화면 노출
        setTableViewData(results: [])
        
        // 검색 api 호출
        ApiRequestManager.getITunesSearchList(text: text) {
            (response: ApiResult<[Result]>) in

            switch response {
            case .apiFail(let error) :
                LOG("apiFail -> \(error)")

            case .apiSuccess(let data) :
                LOG("apiSuccess -> \(data)")

                DispatchQueue.main.async {
                    self.setTableViewData(results: data)
                }
            }
        }
    }
    
    
    
    
    // MARK:- cell protocol
    func openClick(id: Int) {
        showDetailViewController(id: id)
    }
    
    
    
    
    // MARK:- setting section
    func recentSearchSection() -> Int {
        var sction:Int = -1
        if !mIsFiltering && !mIsShowResult {
            sction += 1
        }
        return sction
    }
    func filterSection() -> Int {
        var sction:Int = recentSearchSection()
        if mIsFiltering && !mIsShowResult {
            sction += 1
        }
        return sction
    }
    func searchResultSection() -> Int {
        var sction:Int = filterSection()
        if mIsShowResult {
            sction += 1
        }
        return sction
    }
    func maxSection() -> Int {
        return searchResultSection() + 1
    }
    
    func getSectionType(section: Int) -> SEARCH_SECTION {
        var secType:SEARCH_SECTION = SEARCH_SECTION.init(rawValue: section) ?? .NONE
        
        switch section {
        case recentSearchSection():
            secType = .RECENT_SEARCH
            
        case filterSection():
            secType = .FILTER
            
        case searchResultSection():
            secType = .SEARCH_RESULT
            
        case maxSection():
            secType = .NONE
            
        default:
            break
        }
        return secType
    }
}




// MARK: - extension UITableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    // section
    func numberOfSections(in tableView: UITableView) -> Int {
        return maxSection()
    }
    
    // row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType:SEARCH_SECTION = getSectionType(section: section)

        if sectionType == .RECENT_SEARCH
            || sectionType == .FILTER {
            return mRecentSearchList.count
            
        } else if sectionType == .SEARCH_RESULT {
            return mSearchResults.count
        }
        return 0
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType:SEARCH_SECTION = getSectionType(section: indexPath.section)
        
        if sectionType == .RECENT_SEARCH {
            let cell:RecentSearchCell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchCell", for: indexPath) as! RecentSearchCell
            cell.setData(text: mRecentSearchList[indexPath.row])
            return cell
            
        } else if sectionType == .FILTER {
            let cell:RecentSearchFilterCell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchFilterCell", for: indexPath) as! RecentSearchFilterCell
            cell.setData(text: mRecentSearchList[indexPath.row], filterText: mSearchController.searchBar.text ?? "")
            return cell
            
        } else if sectionType == .SEARCH_RESULT {
            let cell:SearchResultCell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
            if mSearchResults.count > indexPath.row {
                cell.setData(searchProtocol: self, result: mSearchResults[indexPath.row])
            }
            return cell
            
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType:SEARCH_SECTION = getSectionType(section: indexPath.section)
        
        if sectionType == .RECENT_SEARCH {
            return RecentSearchCell.CELL_HEIGHT

        } else if sectionType == .FILTER {
            return RecentSearchFilterCell.CELL_HEIGHT
            
        } else if sectionType == .SEARCH_RESULT {
            return UITableView.automaticDimension
        }
        return 0
    }
    
    // header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType:SEARCH_SECTION = getSectionType(section: section)
        
        if sectionType == .RECENT_SEARCH {
            let view:RecentSearchHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RecentSearchHeaderView") as! RecentSearchHeaderView
            return view
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionType:SEARCH_SECTION = getSectionType(section: section)
        
        if sectionType == .RECENT_SEARCH {
            return RecentSearchHeaderView.CELL_HEIGHT
        }
        return 0
    }
    
    // select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType:SEARCH_SECTION = getSectionType(section: indexPath.section)

        if sectionType == .RECENT_SEARCH {
            clickSearchItem(text: mRecentSearchList[indexPath.row])

        } else if sectionType == .FILTER {
            clickSearchItem(text: mRecentSearchList[indexPath.row])
            
        } else if sectionType == .SEARCH_RESULT {
            showDetailViewController(id : mSearchResults[indexPath.row].trackId)
        }
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
        if !mIsShowResult {
            filterRecentSearch(text: "")
        }
    }
    
    // end editing
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if !mIsShowResult {
            filterRecentSearch(text: "")
        }
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
        
        // 검색하기
        clickSearchItem(text: searchText)
    }
    
    // cancel
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterRecentSearch(text: "")
    }

}
