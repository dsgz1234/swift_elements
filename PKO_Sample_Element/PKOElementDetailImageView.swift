//
// PKOElementDetailImageView.swift
// PKO_swift_test
//
// Created by sunjie on 14-10-16.
// Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit

class PKOElementDetailImageView: UIView {
    
    var detailController:PKOElementDetailViewController?
    var element = PKOElementDataModel()
    
    //这里没有弄明白，我重写了init(frame: CGRect)，会提示需要重写init()，init(coder aDecoder: NSCoder)，不然会报错

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //通过frame初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapAction:")//添加点击（属于手势识别）事件
        self.addGestureRecognizer(tapGestureRecognizer)//将该点击事件添加到view的手势识别中
    }
    
    //点击事件，点击时执行控制器中的flipImageView方法，功能是view翻转
    func tapAction(tapGestureRecognizer: UITapGestureRecognizer){
        self.detailController?.flipImageView()
    }
    
    override func drawRect(rect: CGRect)
    {
        //绘制背景图
        let image = self.element.imageForDetailElementTileView as UIImage
        let imageRect = CGRectMake(0, 0, image.size.width, image.size.height)
        image.drawInRect(imageRect)
        
        //draw the element name
        var font = UIFont.boldSystemFontOfSize(36)
        var stringSize = self.element.name.sizeWithAttributes([NSFontAttributeName:font]) as CGSize
        var point = CGPointMake((self.bounds.size.width-stringSize.width)/2, self.bounds.size.height/2-50)
        self.element.name.drawAtPoint(point, withAttributes: [NSFontAttributeName:font])
        
        //draw the element number
        font = UIFont.boldSystemFontOfSize(48)
        point = CGPointMake(10, 10)
        self.element.atomicNumber.description.drawAtPoint(point, withAttributes: [NSFontAttributeName:font])
        
        //draw the element symbol
        font = UIFont.boldSystemFontOfSize(96)
        stringSize = self.element.symbol.sizeWithAttributes([NSFontAttributeName:font]) as CGSize
        point = CGPointMake((self.bounds.size.width-stringSize.width)/2, self.bounds.size.height-120)
        self.element.symbol.drawAtPoint(point, withAttributes: [NSFontAttributeName:font])
    }
    
    //通过指定高度生成倒影图，方法完全照搬官方sample，
    func reflectedImageWithHeight(height: UInt) ->UIImage{
        //这里注意，swift不能直接在CG方法中用nil，需要声明一个变量
        var nilUnsafeMutablePointer: UnsafeMutablePointer<Void> = nil
        //rgb颜色容器，RGBA和CMYK的区别我会另开博文去说这个
        var colorSpace  = CGColorSpaceCreateDeviceRGB()
        var int32CGImageAlphaInfo = CGImageAlphaInfo.PremultipliedLast.rawValue
        var bitmapInfo = CGBitmapInfo(rawValue: int32CGImageAlphaInfo)
        
        //使用CG绘制位图上下文,以下是方法的用法，网上抓的，大家可以试一下具体用法。
        //参数data指向绘图操作被渲染的内存区域，这个内存区域大小应该为（bytesPerRow*height）个字节。如果对绘制操作被渲染的内存区域并无特别的要求，那么可以传递NULL给参数date。
        //参数width代表被渲染内存区域的宽度。
        //参数height代表被渲染内存区域的高度。
        //参数bitsPerComponent被渲染内存区域中组件在屏幕每个像素点上需要使用的bits位，举例来说，如果使用32-bit像素和RGB颜色格式，那么RGBA颜色格式中每个组件在屏幕每个像素点上需要使用的bits位就为32/4=8。
        //参数bytesPerRow代表被渲染内存区域中每行所使用的bytes位数。
        //参数colorspace用于被渲染内存区域的“位图上下文”。
        //参数bitmapInfo指定被渲染内存区域的“视图”是否包含一个alpha（透视）通道以及每个像素相应的位置，除此之外还可以指定组件式是浮点值还是整数值。
        var mainViewContentContext = CGBitmapContextCreate(nilUnsafeMutablePointer, Int(self.bounds.size.width), Int(height), Int(8), Int(0), colorSpace, int32CGImageAlphaInfo)
        
        //注意，swift操作CG是不需要释放的，CG内部的GC已经处理了
        
        //调整位图位置，CGContextTranslateCTM为位移方法
        var translateVertical = CGFloat(self.bounds.size.height) - CGFloat(height)
        //这里相当于翻转
        CGContextTranslateCTM(mainViewContentContext, 0, -translateVertical)
        
        //将该位图渲染到layer层，layer层是view的根层，这里相当与copy一个self
        self.layer.renderInContext(mainViewContentContext!)
        
        //根据位图上下文生成位图
        var mainViewContentBitmapContext = CGBitmapContextCreateImage(mainViewContentContext)
        
        //创建一个mask，确认刚才生成的位图那些是需要显示的，这里主要用它的渐变功能，image mask就像是用于表征色彩放在页面的哪一部分
        var gradientMaskImage = PKOElementDetailImageView.AEViewCreateGradientImage(UInt(1), pixelsHigh: UInt(height))
        
        //将位图需要显示的部分显示出来
        var reflectionImage = CGImageCreateWithMask(mainViewContentBitmapContext, gradientMaskImage)
        
        //通过image生成UIImage，并返回
        var theImage = UIImage(CGImage: reflectionImage!)
        return theImage
    }
    
    class func AEViewCreateGradientImage ( pixelsWide: UInt, pixelsHigh: UInt) ->CGImageRef {
        var nilUnsafeMutablePointer: UnsafeMutablePointer<Void> = nil
        var colorSpace = CGColorSpaceCreateDeviceGray()
        var int32CGImageAlphaInfo = CGImageAlphaInfo.None.rawValue
        var bitmapInfo = CGBitmapInfo(rawValue: int32CGImageAlphaInfo)
        //使用CG绘制位图上下文，渐变色位图
        var gradientBitmapContext = CGBitmapContextCreate(nilUnsafeMutablePointer, Int(pixelsWide), Int(pixelsHigh),
            Int(8), Int(0), colorSpace, int32CGImageAlphaInfo)
        
        //创建渐变对象，对于CG渐变我会在开博文详细解释
        var colors: [CGFloat] = [0.0, 1.0,1.0, 1.0]
        var nilUnsafePointer: UnsafePointer<CGFloat> = nil
        var grayScaleGradient = CGGradientCreateWithColorComponents(colorSpace, colors, nilUnsafePointer, Int(2))
        
        //渐变的开始点和结束点
        var gradientStartPoint = CGPointZero
        var gradientEndPoint = CGPointMake(0, CGFloat(pixelsHigh))
        
        //填充渐变色
        CGContextDrawLinearGradient(gradientBitmapContext, grayScaleGradient, gradientStartPoint, gradientEndPoint, CGGradientDrawingOptions())
        
        //通过image生成UIImage，并返回
        var theCGImage = CGBitmapContextCreateImage(gradientBitmapContext)
        return theCGImage!
    }
}
