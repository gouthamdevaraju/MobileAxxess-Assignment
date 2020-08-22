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
    let viewOverLay = UIView()
    
    //MARK: - ViewController Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Initialising presenter objects
        self.listPresenter = ListPresenter(view: self)
        
        //Fetch list data on load
        initiateFetchingListData()
        
        //UI Methods
        configureTableView()
        configureSortButton()
    }
}

extension ListViewController: ListViewProtocol{
    
    //MARK: - Fetch Data Methods
    func initiateFetchingListData(){
        
        //Fetch List data from Server
        listPresenter?.fetchListFromServer()
    }
    
    func handleListDataResponse(){
        
        //Unhide placeholder after loading data and load actual data
        //Checking list data for testing
        self.tableView.reloadData()
    }
        
    //MARK: - UI Methods
    func configureTableView(){
        
        //Creating and add table view on viewcontroller view
        self.tableView.register(ListTableViewCell.self, forCellReuseIdentifier: "ListTableViewCell")
        self.tableView.separatorInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
    }
    
    func configureSortButton(){
        
        let btnSort = UIButton(type: .custom)
        btnSort.setImage(UIImage(named: "sort_icon"), for: .normal)
        btnSort.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnSort.addTarget(self, action: #selector(self.sortButtonAction), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnSort)

    }
    
    func configureSortView(){
        
        viewOverLay.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height);
        viewOverLay.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        view.addSubview(viewOverLay)
                
        let stackViewSortElements  = UIStackView()
        stackViewSortElements.axis = NSLayoutConstraint.Axis.vertical
        stackViewSortElements.distribution = UIStackView.Distribution.equalSpacing
        stackViewSortElements.alignment = UIStackView.Alignment.center
        stackViewSortElements.backgroundColor = .white
        stackViewSortElements.spacing = 0.5
        stackViewSortElements.translatesAutoresizingMaskIntoConstraints = false
        viewOverLay.addSubview(stackViewSortElements)

        NSLayoutConstraint.activate([
            stackViewSortElements.leadingAnchor.constraint(equalTo: viewOverLay.leadingAnchor),
            stackViewSortElements.topAnchor.constraint(equalTo: viewOverLay.topAnchor),
            stackViewSortElements.trailingAnchor.constraint(equalTo: viewOverLay.trailingAnchor)
        ])

        if let list_data_types = listPresenter?.list_data_types{

            for string_tyep in list_data_types{

                let myFirstButton = UIButton()
                myFirstButton.setTitle(string_tyep, for: .normal)
                myFirstButton.setTitleColor(.black, for: .normal)
                myFirstButton.backgroundColor = .white
                myFirstButton.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
                myFirstButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
                myFirstButton.addTarget(self, action: #selector(sortButtonSelectedAction(_:)), for: .touchUpInside)
                stackViewSortElements.addSubview(myFirstButton)

                stackViewSortElements.addArrangedSubview(myFirstButton)
            }
        }
    }
    
    //MARK: - Button Actions
    @objc func sortButtonAction(){
        
        print("Bar button tapped")
        
        //Configure sort view once the data is available
        configureSortView()
    }
    
    @objc func sortButtonSelectedAction(_ sender: UIButton){
        
        //Send sort string to presenter and sort the array based on strig passed to it
        viewOverLay.removeFromSuperview()
        
//        let sortedArray = listPresenter?.list_data!.sorted { $0.type < $1.type }

    }
    
    
    // MARK: - Table view data source and delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let list_count = listPresenter?.list_data?.count{
            return list_count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else {
            fatalError("unable to dequeue cell")
        }
        
        if let list_data = listPresenter?.list_data{
            cell.configureCellData(list_data[indexPath.row])
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewOverLay.removeFromSuperview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewOverLay.removeFromSuperview()
    }
    
}
