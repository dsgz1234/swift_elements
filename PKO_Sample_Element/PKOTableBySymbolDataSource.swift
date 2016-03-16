//
//  PKOTableBySymbolDataSource.swift
//  PKO_swift_test
//
//  Created by sunjie on 14-10-26.
//  Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit

class PKOTableBySymbolDataSource: NSObject, PKOTableDataSourceProtocol {
   
    var name : String{
        get{
            return "Test3"
        }
    }
    
    var navigationBarName : String{
        get{
            return "test3"
        }
    }
    
    var tabBarImage : UIImage{
        get{
            return UIImage(named: "symbol_tab")!
        }
    }
    
    var tableViewStyle : UITableViewStyle{
        get{
            return UITableViewStyle.Plain
        }
    }
    
    func elementDataModelForIndexPath(indexPath: NSIndexPath) -> PKOElementDataModel {
        let symbolLetter = PKOElementDataService.sharedElementDataService.symbolLetterArray[indexPath.section]
        return PKOElementDataService.sharedElementDataService.elementSymbolDictionarys[symbolLetter]![indexPath.row]
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        return PKOElementDataService.sharedElementDataService.symbolLetterArray[section]
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String] {
        return PKOElementDataService.sharedElementDataService.symbolLetterArray
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : PKOElementTableViewCell = tableView.dequeueReusableCellWithIdentifier("ElementTableViewCell", forIndexPath: indexPath) as! PKOElementTableViewCell
        var element = self.elementDataModelForIndexPath(indexPath)
        cell.element = element
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let symbolLetter = PKOElementDataService.sharedElementDataService.symbolLetterArray[section]
        return PKOElementDataService.sharedElementDataService.elementSymbolDictionarys[symbolLetter]!.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return PKOElementDataService.sharedElementDataService.symbolLetterArray.count
    }
    
}
