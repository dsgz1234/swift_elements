//
//  PKOTableByNameDataSource.swift
//  PKO_swift_test
//
//  Created by sunjie on 14-10-13.
//  Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit

class PKOTableByNameDataSource: NSObject, PKOTableDataSourceProtocol {
    
    var name : String{
        get{
            return "Test1"
        }
    }
    
    var navigationBarName : String{
        get{
            return "test1"
        }
    }
    
    var tabBarImage : UIImage{
        get{
            return UIImage(named: "name_tab")!
        }
    }
    
    var tableViewStyle : UITableViewStyle{
        get{
            return UITableViewStyle.Plain//平铺格式，分组时组名会悬浮在页面上方，对应的Group可以去查一下什么效果。
        }
    }
    
    func elementDataModelForIndexPath(indexPath: NSIndexPath) -> PKOElementDataModel {
        return PKOElementDataService.sharedElementDataService.elementByNameArray[indexPath.row]
    }
    
    //Asks the data source for a cell to insert in a particular location of the table view.(required)
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ElementTableViewCell", forIndexPath: indexPath) as! PKOElementTableViewCell//根据标识获取我们自定义的TableViewCell
        var element = self.elementDataModelForIndexPath(indexPath)//根据索引获取对象
        cell.element = element
        return cell
    }
    
    //Tells the data source to return the number of rows in a given section of a table view. (required)
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PKOElementDataService.sharedElementDataService.elementByNameArray.count//返回数据中对应分组的总数
    }

}
