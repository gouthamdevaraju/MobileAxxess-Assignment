//
//  ListViewController.swift
//  AxxessAssignment
//
//  Created by Goutham Mac Mini on 22/08/20.
//  Copyright © 2020 goutham. All rights reserved.
//

import UIKit
import AMShimmer

class ListViewController: UITableViewController {

    //MARK: - Properties
    var listPresenter : ListPresenter?
    var loader_view = VDSCircleAnimation()
    var tableViewList: UITableView!
    
    //MARK: - ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Initialising presenter objects
        self.listPresenter = ListPresenter(view: self)
        
        //Fetch list data on load
        initiateFetchingListData()
    }
}

extension ListViewController: ListViewProtocol{
    
    //MARK: - Fetch Data Methods
    func initiateFetchingListData(){
        
        //Show loader
        showLoaderAnimation()
        
        //Fetch List data from Server
        listPresenter?.fetchListFromServer()
        
        //UI Methods
        addView()
        addTableView()
    }
    
    func handleListDataResponse(){
        
        //Stop Loader
        loader_view.removeFromSuperview()
        
        //Unhide placeholder after loading data and load actual data
        //Checking list data for testing
        
    }
    
    func showLoaderAnimation(){

        loader_view = VDSCircleAnimation(frame: CGRect(x: view.frame.width/2-(view.frame.width/5)/2, y: view.frame.height/2-(view.frame.height/5)/2, width: view.frame.width/5, height: view.frame.height/5))
        view.addSubview(loader_view)
    }
    
    //MARK: - UI Methods
    
    func addView(){
        
//        let viewSimple = UIView(frame: CGRect(x: 40, y: 100, width: 200, height: 500))
//        viewSimple.backgroundColor = .red
//        self.view.addSubview(viewSimple)
        
//        AMShimmer.start(for: viewSimple)
    }
    
    func configureTableView(){
        
        //Creating and add table view on viewcontroller view
        tableViewList = UITableView(frame: .zero)
        tableViewList.backgroundColor = .red
        self.view.addSubview(tableViewList)
        
        tableViewList.translatesAutoresizingMaskIntoConstraints = false
        tableViewList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableViewList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableViewList.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableViewList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0//mainViewModelObj?.dataItemList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: CCDataItemTableViewCell.self, for: indexPath)

        if let dataInfo = mainViewModelObj?.dataItemList![indexPath.row] {
            cell.dataValue = dataInfo
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = CCDetailViewController()
        if let dataInfo = mainViewModelObj?.dataItemList![indexPath.row] {
            detailView.dataValue = dataInfo
        }
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    
}
