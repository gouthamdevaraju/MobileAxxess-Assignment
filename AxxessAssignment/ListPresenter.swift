//
//  ListPresenter.swift
//  AxxessAssignment
//
//  Created by Goutham Mac Mini on 22/08/20.
//  Copyright © 2020 goutham. All rights reserved.
//

import Foundation

class ListPresenter: ListPresenterProtocol{
    
    var list_viewController: ListViewController? = nil
    
    var list_data: [ListModel]?
    var list_data_filtered_results: [ListModel]?
    
    var list_data_types: [String]? = [""]
    
    //MARK: - Methods
    required init(view: ListViewController) {
        self.list_viewController = view
    }
    
    func fetchListFromServer() {
        
        //Fetch profile
        
        let headers = [ACCEPT : APPLICATION_JSON]
        
        _ = NetworkInterface.getRequest(.get_list, headers: headers as NSDictionary, params: nil, requestCompletionHander: { (success, data, response, error, header) -> (Void)in
            
            if success{
                
                do
                {
                    let decoder = JSONDecoder()
                    let listData = try decoder.decode([ListModel].self, from: data!)
                    self.processListDataAndPassToViews(list_data_: listData)
                }
                catch{
                    print("AirPort model codable error: \(error)")
                    self.handleErrorFromListDetails()
                }
            }
            else{
                //Handle API fetching failure case
                self.handleErrorFromListDetails()
            }
        })
        
    }
    
    func processListDataAndPassToViews(list_data_: [ListModel]) {
        
        //Paass data to the views
        list_data = list_data_

        cacheSortTypes()
        
        DispatchQueue.main.async {
            self.list_viewController?.handleListDataResponse()
        }
    }
    
    func handleErrorFromListDetails() {
        
    }
    
    func cacheSortTypes(){
        
        list_data_types?.removeAll()
        if let list_data = list_data{
            for listData in list_data{
                if let type = listData.type{
                    if (!(list_data_types?.contains(type))!)
                    {
                        list_data_types?.append(type)
                    }
                }
            }
        }
    }
    
    func sortListData(){
        
//        if let data_list = list_data{
            
            //Add sort logic
            
//            let arr = data_list.filter{
//                if let city_name = $0.city{
//                    return city_name.lowercased().contains(city_charaters.lowercased())
//                }
//                else{
//                    return false
//                }
//            }
//
//            if arr.count > 0
//            {
//                airport_data_filtered_results = []
//                airport_data_filtered_results = arr
//            }
//            else
//            {
//                airport_data_filtered_results = []
//            }
//        }
        
    }
    
}
