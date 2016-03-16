//
//  PKOTableByNumberDataSource.swift
//  PKO_swift_test
//
//  Created by sunjie on 14-10-26.
//  Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit

class PKOTableByNumberDataSource: NSObject, PKOTableDataSourceProtocol  {
   
    var name : String{
        get{
            return "Test2";
        }
    }
    
    var navigationBarName : String{
        get{
            return "test2";
        }
    }
    
    var tabBarImage : UIImage{
        get{
            return UIImage(named: "number_tab")!;
        }
    }
    
    var tableViewStyle : UITableViewStyle{
        get{
            return UITableViewStyle.Plain;
        }
    }
    
    func elementDataModelForIndexPath(indexPath: NSIndexPath) -> PKOElementDataModel {
        return PKOElementDataService.sharedElementDataService.elementByNumberArray[indexPath.row];
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : PKOElementTableViewCell = tableView.dequeueReusableCellWithIdentifier("ElementTableViewCell", forIndexPath: indexPath) as! PKOElementTableViewCell;
        var element = self.elementDataModelForIndexPath(indexPath);
        cell.element = element;
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PKOElementDataService.sharedElementDataService.elementByNumberArray.count;
    }
    
}
