//
//  PKOElementDataModel.swift
//  PKO_swift_test
//
//  Created by sunjie on 14-10-12.
//  Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit//swift部分包不需要import，但是ui还是要import进来才会生效

class PKOElementDataModel {
    
    var atomicNumber:Int = 0//前面说过，swift必须要对属性进行初始化，当然也可以用?来定义可选属性
    var name:String = ""//所有属性均使用swift类型，当然也可以使用NSString、NSNumber
    var symbol:String = ""
    var state:String = ""
    var atomicWeight:String = ""
    var discoveryYear:String = ""
    var group:Int = 0
    var period:Int = 0
    
    var imageForDetailElementTileView:UIImage{
        get{
            return UIImage(named:self.state+"_256")!
        }
    }
    
    var imageForCellIconElementView:UIImage{
        get{
            return UIImage(named:self.state+"_37")!
        }
    }
    
    func initWithDictionary(aDictionary : NSDictionary) ->PKOElementDataModel{//个人并不认为这种方法是合理的，但是sample就是这么干的，照抄了
        self.atomicNumber = aDictionary["atomicNumber"] as! Int
        self.atomicWeight = aDictionary["atomicWeight"] as! String
        self.discoveryYear = aDictionary["discoveryYear"] as! String
        self.name = aDictionary["name"] as! String
        self.symbol = aDictionary["symbol"] as! String
        self.state = aDictionary["state"] as! String
        self.group = aDictionary["group"] as! Int
        self.period = aDictionary["period"] as! Int
        return self
    }
}
