//
//  SearchDetailViewController.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit


enum SEARCH_DETAIL_ROW:Int {
    case APP_INFO = 0
    case RELEASE_NOTE
    case COUNT
}


class SearchDetailViewController: UIViewController, SearchViewProtocol {
    
    @IBOutlet weak var mTableView: UITableView!
    
    var mId: Int = 0
    
    var mResult: Result? = nil
    
    var mIsExpandReleaseNote:Bool = false
    
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
        
        mTableView.register(UINib(nibName: "SearchDetailAppInfoCell", bundle: nil), forCellReuseIdentifier: "SearchDetailAppInfoCell")
        mTableView.register(UINib(nibName: "SearchDetailReleaseNoteCell", bundle: nil), forCellReuseIdentifier: "SearchDetailReleaseNoteCell")
        
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

    // row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SEARCH_DETAIL_ROW.COUNT.rawValue
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowType: SEARCH_DETAIL_ROW = SEARCH_DETAIL_ROW.init(rawValue: indexPath.row) ?? .COUNT
        
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
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let rowType:SEARCH_DETAIL_ROW = SEARCH_DETAIL_ROW.init(rawValue: indexPath.row) ?? .COUNT
        
        if rowType == .APP_INFO {
            return SearchDetailAppInfoCell.CELL_HEIGHT

        } else if rowType == .RELEASE_NOTE {
            return UITableView.automaticDimension
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowType: SEARCH_DETAIL_ROW = SEARCH_DETAIL_ROW.init(rawValue: indexPath.row) ?? .COUNT
        
        if rowType == .RELEASE_NOTE {
            // 셀 클릭 시 릴리즈 노트 더보기 기능
            if !mIsExpandReleaseNote {
                mIsExpandReleaseNote = true
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        }
    }
}
