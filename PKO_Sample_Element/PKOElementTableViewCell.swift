//
//  PKOElementTableViewCell.swift
//  PKO_swift_test
//
//  Created by sunjie on 14-10-14.
//  Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit

class PKOElementTableViewCell: UITableViewCell {
    
    var element:PKOElementDataModel {
        get{
            return self.element
        }
        set(element){
            var cellIcon = self.contentView.viewWithTag(1) as! PKOElementTableViewCellIcon//获取列表行左侧自定义的view
            cellIcon.element = element//将元素对象赋值给自定义view
            cellIcon.setNeedsDisplay()//该方法为异步，告诉系统来给我绘图
            
            var label = self.contentView.viewWithTag(2) as! UILabel//获取列表行文字
            label.text = element.name
            label.setNeedsDisplay()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
