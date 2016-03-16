//
//  PKOTableDataSourceProtocol.swift
//  PKO_swift_test
//
//  Created by sunjie on 14-10-13.
//  Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit

protocol PKOTableDataSourceProtocol: UITableViewDataSource{
    
    var name: String{ get }//tabBarItem名称
    var navigationBarName: String{ get }//导航标题
    var tabBarImage: UIImage{ get }//tabBarItem图标
    var tableViewStyle: UITableViewStyle{ get }//table样式
    
    func elementDataModelForIndexPath(indexPath: NSIndexPath) ->PKOElementDataModel//通过索引获取数据对象
}
