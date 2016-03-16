//
//  PKOElementDetailViewController.swift
//  PKO_swift_test
//
//  Created by sunjie on 14-10-16.
//  Copyright (c) 2014年 popkidorc. All rights reserved.
//

import UIKit

class PKOElementDetailViewController: UIViewController {
    
    var element = PKOElementDataModel()
    
    var frontViewIsVisible = true//是否正面显示标识
    
    var subView:UIView?
    var detailImage:PKOElementDetailImageView?
    var detailImageFlipped = PKOElementDetailImageFlippedView()
    var reflectionImage = UIImageView()
    
    let reflectionRadio = 0.35//倒影的高度比例
    
    //Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.frontViewIsVisible = true
        
        //绘制图片view的父view
        let imageSize = CGSizeMake(256, 256)
        let detailRect = CGRectMake((self.view.bounds.size.width - imageSize.width)/2, (self.view.bounds.size.height - imageSize.height)/2 - 40, imageSize.width, imageSize.height)
        let subView = UIView(frame: detailRect)
        self.subView = subView
        self.view.addSubview(subView)
        
        //绘制图片
        let imageRect = CGRectMake(0, 0, imageSize.width, imageSize.height)
        let detailImage = PKOElementDetailImageView(frame: imageRect)
        detailImage.element = self.element
        detailImage.detailController = self
        self.detailImage = detailImage
        self.subView?.addSubview(detailImage)
        
        //绘制反面图片
        let detailImageFlipped = PKOElementDetailImageFlippedView(frame: imageRect)
        detailImageFlipped.element = self.element
        detailImageFlipped.detailController = self
        self.detailImageFlipped = detailImageFlipped
        
        //创建倒影图
        var reflectionRect = imageRect
        reflectionRect.size.height = CGFloat(CGRectGetHeight(reflectionRect)) * CGFloat(reflectionRadio)
        reflectionRect = CGRectOffset(reflectionRect, 0, CGRectGetHeight(imageRect))
        let reflectionView = UIImageView(frame: reflectionRect)
        self.reflectionImage = reflectionView
        let height = (self.detailImage?.bounds.height as CGFloat!) * CGFloat(reflectionRadio)
        self.reflectionImage.image = self.detailImage?.reflectedImageWithHeight(UInt(height))
        self.reflectionImage.alpha = 0.3
        //添加倒影
        self.subView?.addSubview(self.reflectionImage)
    }
    
    //翻转动画
    func flipImageView() {
        UIView.beginAnimations(nil, context:nil)
        //平滑动画效果
        UIView.setAnimationCurve(UIViewAnimationCurve.Linear)
        UIView.setAnimationDuration(1)
        
        var reflectionHeight: CGFloat
        var reflectedImage: UIImage?
        
        //点击正面
        if(self.frontViewIsVisible == true){
            UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: self.subView!, cache: true)
            self.detailImage?.removeFromSuperview()
            self.subView?.addSubview(self.detailImageFlipped)
            
            // 更新倒影
            reflectionHeight = (self.detailImageFlipped.bounds.height as CGFloat) * CGFloat(reflectionRadio)
            reflectedImage = self.detailImageFlipped.reflectedImageWithHeight(UInt(reflectionHeight))
            self.reflectionImage.image = reflectedImage
        }
        //点击反面
        else{
            UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromRight, forView:self.subView!, cache:true)
            self.detailImageFlipped.removeFromSuperview()
            self.subView?.addSubview(self.detailImage!)
            
            // 更新倒影
            reflectionHeight = (self.detailImage!.bounds.height as CGFloat) * CGFloat(reflectionRadio)
            reflectedImage = self.detailImage?.reflectedImageWithHeight(UInt(reflectionHeight))
            self.reflectionImage.image = reflectedImage
        }
        //提交动画
        UIView.commitAnimations()
        //设置是否正面显示标识
        self.frontViewIsVisible = !self.frontViewIsVisible
    }
    
}
