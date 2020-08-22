//
//  ListProtocol.swift
//  AxxessAssignment
//
//  Created by Goutham Mac Mini on 22/08/20.
//  Copyright © 2020 goutham. All rights reserved.
//

import Foundation

protocol ListPresenterProtocol: class {
    
    //For fetching list data
    func fetchListFromServer()
    
    func processListDataAndPassToViews(list_data_: [ListModel])
    func handleErrorFromListDetails()
    
    func cacheSortTypes()
    func sortListData()
}

protocol ListViewProtocol: class {
    
    //For fetching EOS profile data
    func initiateFetchingListData()
    func handleListDataResponse()

}
