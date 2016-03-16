//
//  PKOElementTableViewController.swift
//  PKO_swift_test
//
//  Created by sunjie on 14-10-13.
//  Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit

class PKOElementTableViewController: UITableViewController {
    
    var dataSource: PKOTableDataSourceProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self.dataSource
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Pass the selected object to the new view controller.
        var indexPath = self.tableView.indexPathForSelectedRow
        var element = self.dataSource?.elementDataModelForIndexPath(indexPath!)//根据索引获取对象
        var elementDetailViewController = segue.destinationViewController as! PKOElementDetailViewController
        elementDetailViewController.element = element!//将数据对象赋值给明细页面的控制器
    }
    
}
