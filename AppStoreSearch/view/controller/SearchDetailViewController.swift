//
//  SearchDetailViewController.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

class SearchDetailViewController: UIViewController, SearchViewProtocol {
    
    @IBOutlet weak var mTableView: UITableView!
    
    var mId: Int = 0
    
    var mResult: Result? = nil
    
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
        
        mTableView.register(UINib(nibName: "SearchDetailAppInfoCell", bundle: nil), forCellReuseIdentifier: "SearchDetailAppInfoCell")
        mTableView.register(UINib(nibName: "SearchDetailNewFeatureCell", bundle: nil), forCellReuseIdentifier: "SearchDetailNewFeatureCell")
        
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
        return 1
    }
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SearchDetailAppInfoCell = tableView.dequeueReusableCell(withIdentifier: "SearchDetailAppInfoCell", for: indexPath) as! SearchDetailAppInfoCell
        if let result = mResult {
            cell.setData(searchProtocol: self, result: result)
        }
        return cell
        
//        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchDetailAppInfoCell.CELL_HEIGHT
        
    }
    
}
