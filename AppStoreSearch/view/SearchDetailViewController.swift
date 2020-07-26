//
//  SearchDetailViewController.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

class SearchDetailViewController: UIViewController {
    
    @IBOutlet weak var mTableView: UITableView!
    
    var mId: Int = 0
    
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
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
