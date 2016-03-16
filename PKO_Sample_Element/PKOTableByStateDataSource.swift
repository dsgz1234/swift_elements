//
//  PKOTableByStateDataSource.swift
//  PKO_swift_test
//
//  Created by sunjie on 14-10-16.
//  Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit

class PKOTableByStateDataSource: NSObject, PKOTableDataSourceProtocol {
    
    var name : String{
        get{
            return "Test4"
        }
    }
    
    var navigationBarName : String{
        get{
            return "test4"
        }
    }
    
    var tabBarImage : UIImage{
        get{
            return UIImage(named: "state_tab")!
        }
    }
    
    var tableViewStyle : UITableViewStyle{
        get{
            return UITableViewStyle.Plain
        }
    }
    
    func elementDataModelForIndexPath(indexPath: NSIndexPath) -> PKOElementDataModel {
        let state = PKOElementDataService.sharedElementDataService.stateArray[indexPath.section]
        return PKOElementDataService.sharedElementDataService.elementStateDictionarys[state]![indexPath.row]
    }
    
    //Asks the data source for the title of the header of the specified section of the table view.
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        return PKOElementDataService.sharedElementDataService.stateArray[section]//根据组索引获取对应组名称
    }
    
    //Asks the data source to return the titles for the sections for a table view.
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String] {
        return PKOElementDataService.sharedElementDataService.stateArray//获取组名称集合
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ElementTableViewCell", forIndexPath: indexPath) as! PKOElementTableViewCell
        var element = self.elementDataModelForIndexPath(indexPath)
        cell.element = element
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let state = PKOElementDataService.sharedElementDataService.stateArray[section]
        return PKOElementDataService.sharedElementDataService.elementStateDictionarys[state]!.count
    }
    
    //Asks the data source to return the number of sections in the table view.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return PKOElementDataService.sharedElementDataService.stateArray.count
    }

}
