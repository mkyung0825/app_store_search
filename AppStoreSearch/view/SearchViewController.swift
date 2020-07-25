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
//        mTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }

}




// MARK: - extension UITableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}




// MARK: - extension UISearchController
extension SearchViewController: UISearchBarDelegate {

    // changed
    func searchBar(_ searchBar: UISearchBar, textDidChange: String) {
        guard let searchText = searchBar.text else { return }
    }
    
    // begin editing
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    // end editing
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    
    // MARK:- button event
    // search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    
    // cancel
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }

}
