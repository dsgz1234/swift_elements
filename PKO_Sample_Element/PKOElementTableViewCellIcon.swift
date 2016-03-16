//
//  PKOElementTableViewCellIcon.swift
//  PKO_swift_test
//
//  Created by sunjie on 14-10-16.
//  Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit

class PKOElementTableViewCellIcon: UIView {
    
    var element = PKOElementDataModel()
    
    override func drawRect(rect: CGRect) {
        // 绘制背景图
        var point: CGPoint
        let image = self.element.imageForCellIconElementView as UIImage
        let elementRect = CGRectMake(0, 0, image.size.width, image.size.height)
        image.drawInRect(elementRect)
        
        // draw the element number
        var font = UIFont.boldSystemFontOfSize(11)
        point = CGPointMake(3,2)
        self.element.name.drawAtPoint(point, withAttributes: [NSFontAttributeName:font])//swift都是通过dictionary来指定样式的，例如字体样式的键就是NSFontAttributeName
        
        // draw the element symbol
        font = UIFont.boldSystemFontOfSize(18)
        let stringSize = self.element.symbol.sizeWithAttributes([NSFontAttributeName:font]) as CGSize
        point = CGPointMake((elementRect.size.width-stringSize.width)/2, 14.0)
        self.element.symbol.drawAtPoint(point, withAttributes: [NSFontAttributeName:font])
    }
}
