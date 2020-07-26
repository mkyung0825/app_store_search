//
//  SearchDetailViewController.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit


enum SEARCH_DETAIL_SECTION:Int {
    case APP_INFO = 0
    case RELEASE_NOTE
    case SCREEN_SHOT
    case DESC
    case COUNT
}


class SearchDetailViewController: UIViewController, SearchViewProtocol {
    
    @IBOutlet weak var mTableView: UITableView!
    
    var mId: Int = 0
    
    var mResult: Result? = nil
    
    var mIsExpandReleaseNote:Bool = false
    
    var mIsExpandDesc:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.\
       setUI()
    }

    
    // MARK:- set ui
    func setUI() {
        
        setTableView()
    }
    
    
    func setTableView() {
        mTableView.delegate = self
        mTableView.dataSource = self
        
        mTableView.separatorStyle = .none
        
        mTableView.rowHeight = UITableView.automaticDimension
        mTableView.estimatedRowHeight = 200
        
        mTableView.register(UINib(nibName: "RecentSearchHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RecentSearchHeaderView")
        
        mTableView.register(UINib(nibName: "SearchDetailAppInfoCell", bundle: nil), forCellReuseIdentifier: "SearchDetailAppInfoCell")
        mTableView.register(UINib(nibName: "SearchDetailReleaseNoteCell", bundle: nil), forCellReuseIdentifier: "SearchDetailReleaseNoteCell")
        
        mTableView.register(UINib(nibName: "SearchDetailScreenShotCell", bundle: nil), forCellReuseIdentifier: "SearchDetailScreenShotCell")
        mTableView.register(UINib(nibName: "SearchDetailDescriptionCell", bundle: nil), forCellReuseIdentifier: "SearchDetailDescriptionCell")
        
        getData()
    }
    
    func setTableViewData(result: Result) {
        mResult = result
        mTableView.reloadData()
    }
    
    
    // MARK:- get data
    func getData() {
        ApiRequestManager.getITunesSearcDetail(id: mId) {
        (response: ApiResult<[Result]>) in
            
            switch response {
            case .apiFail(let error) :
                LOG("apiFail -> \(error)")

            case .apiSuccess(let data) :
                LOG("apiSuccess -> \(data)")

                DispatchQueue.main.async {
                    if data.count > 0 {
                        self.setTableViewData(result: data[0])
                    }
                }
            }
        }
    }
    
    
    
    
    // MARK:- cell protocol
    func openClick(id: Int) {
    }
    
}





// MARK: - extension UITableView
extension SearchDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return SEARCH_DETAIL_SECTION.COUNT.rawValue
    }
    
    // row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowType: SEARCH_DETAIL_SECTION = SEARCH_DETAIL_SECTION.init(rawValue: indexPath.section) ?? .COUNT
        
        if rowType == .APP_INFO {
            
            let cell:SearchDetailAppInfoCell = tableView.dequeueReusableCell(withIdentifier: "SearchDetailAppInfoCell", for: indexPath) as! SearchDetailAppInfoCell
            if let result = mResult {
                cell.setData(searchProtocol: self, result: result)
            }
            return cell
            
        } else if rowType == .RELEASE_NOTE {
                    
            let cell:SearchDetailReleaseNoteCell = tableView.dequeueReusableCell(withIdentifier: "SearchDetailReleaseNoteCell", for: indexPath) as! SearchDetailReleaseNoteCell
            if let result = mResult {
                cell.setData(searchProtocol: self, result: result, isExpand: mIsExpandReleaseNote)
            }
            return cell
            
        } else if rowType == .SCREEN_SHOT {
            let cell:SearchDetailScreenShotCell = tableView.dequeueReusableCell(withIdentifier: "SearchDetailScreenShotCell", for: indexPath) as! SearchDetailScreenShotCell
            cell.setData(screenshots: mResult?.screenshotUrls ?? [])
            return cell

        } else if rowType == .DESC {
            let cell:SearchDetailDescriptionCell = tableView.dequeueReusableCell(withIdentifier: "SearchDetailDescriptionCell", for: indexPath) as! SearchDetailDescriptionCell
            if let result = mResult {
                cell.setData(searchProtocol: self, result: result, isExpand: mIsExpandDesc)
            }
            return cell

        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let rowType:SEARCH_DETAIL_SECTION = SEARCH_DETAIL_SECTION.init(rawValue: indexPath.section) ?? .COUNT
        
        if rowType == .APP_INFO {
            return SearchDetailAppInfoCell.CELL_HEIGHT

        } else if rowType == .RELEASE_NOTE {
            return UITableView.automaticDimension
            
        } else if rowType == .SCREEN_SHOT {
            let size:CGSize = Common.getImageSizeWithUrl(url: mResult?.screenshotUrls[0] ?? "")
            return (size.height / 2) + SearchDetailScreenShotCell.TOP_MARGIN + SearchDetailScreenShotCell.BOTTOM_MARGIN

        } else if rowType == .DESC {

        }
        return UITableView.automaticDimension
    }
    
    // select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowType: SEARCH_DETAIL_SECTION = SEARCH_DETAIL_SECTION.init(rawValue: indexPath.section) ?? .COUNT
        
        if rowType == .RELEASE_NOTE {
            // 셀 클릭 시 릴리즈 노트 더보기 기능
            if !mIsExpandReleaseNote {
                mIsExpandReleaseNote = true
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        } else if rowType == .DESC {
            // 셀 클릭 시 디스크립션 더보기 기능
            if !mIsExpandDesc {
                mIsExpandDesc = true
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
    
    // header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let rowType:SEARCH_DETAIL_SECTION = SEARCH_DETAIL_SECTION.init(rawValue: section) ?? .COUNT
        
        if rowType == .APP_INFO {

        } else if rowType == .RELEASE_NOTE {

            let view:RecentSearchHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RecentSearchHeaderView") as! RecentSearchHeaderView
            view.setData(title: "새로운 기능")
            return view
            
        } else if rowType == .SCREEN_SHOT {

            let view:RecentSearchHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RecentSearchHeaderView") as! RecentSearchHeaderView
            view.setData(title: "미리보기")
            return view

        } else if rowType == .DESC {
            
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let rowType:SEARCH_DETAIL_SECTION = SEARCH_DETAIL_SECTION.init(rawValue: section) ?? .COUNT
        
        if rowType == .RELEASE_NOTE || rowType == .SCREEN_SHOT {
            return RecentSearchHeaderView.CELL_DETAIL_HEIGHT
        }
        return 0.1
    }
    
    // footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}
