//
//  PKOElementDetailImageFlippedView.swift
//  PKO_swift_test
//
//  Created by sunjie on 14-10-17.
//  Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit

class PKOElementDetailImageFlippedView: PKOElementDetailImageView {
    
    var wikipediaButton: UIButton?
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //子view随着父view(self)的frame大小而自动改变大小
        self.autoresizesSubviews = true
        self.setUpUserInterface()
    }
    
    override func drawRect(rect: CGRect)
    {
        // 绘制背景
        let image = self.element.imageForDetailElementTileView as UIImage
        let imageRect = CGRectMake(0, 0, image.size.width, image.size.height)
        image.drawInRect(imageRect)
        
        // draw the element number
        var font = UIFont.boldSystemFontOfSize(32)
        var point = CGPointMake(10, 10)
        self.element.atomicNumber.description.drawAtPoint(point, withAttributes: [NSFontAttributeName:font])
        
        // draw the element symbol
        font = UIFont.boldSystemFontOfSize(32)
        let stringSize = self.element.name.sizeWithAttributes([NSFontAttributeName:font]) as CGSize
        point = CGPointMake(self.bounds.size.width - stringSize.width - 10, 10)
        self.element.symbol.drawAtPoint(point,withAttributes:[NSFontAttributeName:font])
        
        // draw the element name
        font = UIFont.boldSystemFontOfSize(32)
        point = CGPointMake((self.bounds.size.width - stringSize.width)/2, 80)
        self.element.name.drawAtPoint(point, withAttributes: [NSFontAttributeName:font])
        
        // draw the element weight
        font = UIFont.boldSystemFontOfSize(28)
        point = CGPointMake((self.bounds.size.width - stringSize.width)/2, 160)
        self.element.atomicWeight.drawAtPoint(point, withAttributes: [NSFontAttributeName:font])
        
        
    }
    
    func setUpUserInterface() {
        let buttonFrame = CGRectMake(10.0, 209.0, 234.0, 37.0)
        // 创建一个链接
        self.wikipediaButton = UIButton(type: UIButtonType.System) as? UIButton//按钮样式为系统默认，4个圆角
        self.wikipediaButton?.frame = buttonFrame
        let font = UIFont.boldSystemFontOfSize(22)
        self.wikipediaButton?.titleLabel?.font = font
        self.wikipediaButton?.setTitle("View at Wikipedia", forState: UIControlState.Normal)//任何状态按钮都是高亮
        
        // 按钮在view中的对其方式，水平垂直均居中
        self.wikipediaButton?.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        self.wikipediaButton?.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        
        //添加点击事件，点击手指离开时还在按钮内触发
        self.wikipediaButton?.addTarget(self, action: "jumpToWikipedia:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.wikipediaButton!)
    }
    
    func jumpToWikipedia(sender: AnyObject!){
        var wikiPageString = "http://en.wikipedia.org/wiki/"+self.element.name
        if (!UIApplication.sharedApplication().openURL(NSURL(fileURLWithPath: wikiPageString)))
        {
            // 如果访问链接错误的处理代码
        }
    }
}
