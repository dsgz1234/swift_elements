//
//  PKOElementTabBarViewController.swift
//  PKO_swift_test
//
//  Created by sunjie on 14-10-12.
//  Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit

class PKOElementTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tableViewControllers = [UINavigationController]()//tab中所挂接的viewController集合
        var navigetionController : UINavigationController
        var tableViewController : PKOElementTableViewController
        var tabBarDataSource : PKOTableDataSourceProtocol
        
        //by name
        navigetionController = self.storyboard?.instantiateViewControllerWithIdentifier("navForTableView") as! UINavigationController//获取标识为navForTableView的导航页面控制器
        tableViewController = navigetionController.topViewController as! PKOElementTableViewController//获取该导航页面下所显示的列表控制器
        tabBarDataSource = PKOTableByNameDataSource()//获取数据集
        tableViewController.tabBarItem.title = tabBarDataSource.name//tabbarItem的文字描述
        tableViewController.tabBarItem.image = tabBarDataSource.tabBarImage//tabbarItem的图标
        tableViewController.navigationItem.title = tabBarDataSource.navigationBarName//导航标题
        tableViewController.dataSource = tabBarDataSource//将数据赋值给列表控制器的dataSource
        tableViewControllers.append(navigetionController)//将该导航添加到集合中
        
        //by number
        navigetionController = self.storyboard?.instantiateViewControllerWithIdentifier("navForTableView") as! UINavigationController
        tableViewController = navigetionController.topViewController as! PKOElementTableViewController
        tabBarDataSource = PKOTableByNumberDataSource()
        tableViewController.tabBarItem.title = tabBarDataSource.name
        tableViewController.tabBarItem.image = tabBarDataSource.tabBarImage
        tableViewController.navigationItem.title = tabBarDataSource.navigationBarName
        tableViewController.dataSource = tabBarDataSource
        tableViewControllers.append(navigetionController)
        
        //by symbol
        navigetionController = self.storyboard?.instantiateViewControllerWithIdentifier("navForTableView") as! UINavigationController
        tableViewController = navigetionController.topViewController as! PKOElementTableViewController
        tabBarDataSource = PKOTableBySymbolDataSource()
        tableViewController.tabBarItem.title = tabBarDataSource.name
        tableViewController.tabBarItem.image = tabBarDataSource.tabBarImage
        tableViewController.navigationItem.title = tabBarDataSource.navigationBarName
        tableViewController.dataSource = tabBarDataSource
        tableViewControllers.append(navigetionController)
        
        //by state
        navigetionController = self.storyboard?.instantiateViewControllerWithIdentifier("navForTableView") as! UINavigationController
        tableViewController = navigetionController.topViewController as! PKOElementTableViewController
        tabBarDataSource = PKOTableByStateDataSource()
        tableViewController.tabBarItem.title = tabBarDataSource.name
        tableViewController.tabBarItem.image = tabBarDataSource.tabBarImage
        tableViewController.navigationItem.title = tabBarDataSource.navigationBarName
        tableViewController.dataSource = tabBarDataSource
        tableViewControllers.append(navigetionController)
        
        self.viewControllers = tableViewControllers//将该导航集合赋值给tabbar的viewControllers，将会出现以上4种tabbarItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
