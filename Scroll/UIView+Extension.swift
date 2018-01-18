//
//  UIView+Extension.swift
//  Swift01
//
//  Created by YuanGu on 2017/11/7.
//  Copyright © 2017年 YuanGu. All rights reserved.
//

import UIKit

extension UIView{
    
    public var originX: CGFloat{
        get{
            return self.frame.origin.x
        }
        set(newOriginX){
            var frame = self.frame
            frame.origin.x = newOriginX
            self.frame = frame
        }
    }
    public var originY: CGFloat{
        get{
            return self.frame.origin.y
        }
        set(newOriginY){
            var frame = self.frame
            frame.origin.y = newOriginY
            self.frame = frame
        }
    }
    public var centerX: CGFloat{
        get{
            return self.center.x
        }
        set(newcenterX){
            var center = self.center
            center.x = newcenterX
            self.center = center
        }
    }
    public var centerY:CGFloat {
        get {
            return self.center.y
        }
        set(newCenterY) {
            var center = self.center
            center.y = newCenterY
            self.center = center
        }
    }

    public var height:CGFloat{
        get{
            return self.frame.size.height
        }
        set(newHeight){
            var frame = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }
    public var width:CGFloat {
        get {
            return self.frame.size.width
        }
        set(newWidth) {
            var frame = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }
    public var maxX:CGFloat{
        get {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    public var maxY:CGFloat{
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
    public var size: CGSize{
        get{
            return self.frame.size
        }
        set(newSize){
            var frame = self.frame
            frame.size = newSize
            self.frame = frame
        }
    }
    public func removeAllSubviews(){
        for subview:UIView in self.subviews {
            subview.removeFromSuperview()
        }
    }
    /**
     *  绘制渐变色
     *  @param isHorizontal 是否是水平方向的绘制
     */
    public func graidentLayerWithIsHorizontal(isHorizontal:Bool){
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [UIColor(red: 38/255.0, green: 173/255.0, blue: 252/255.0, alpha: 1.0).cgColor ,
                                UIColor(red: 0/255.0 , green: 132/255.0, blue: 255/255.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0 ,1.0]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = isHorizontal ? CGPoint.init(x: 1, y: 0) : CGPoint.init(x: 0, y: 1)
        gradientLayer.frame = self.bounds
        
        self.layer.addSublayer(gradientLayer)
    }
    /**
     *  绘制所有圆角
     *  @param radiu 边角半径
     */
    public func cornerLayer(radiu: CGFloat){
        let path = UIBezierPath.init(roundedRect: self.bounds,
                                     byRoundingCorners: .allCorners,
                                     cornerRadii: CGSize.init(width: radiu, height: radiu))
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.path = path.cgPath
        
        self.layer.mask = layer
    }
    
    /**
     绘制边缘线条
     
     - parameter rect frame
     - parameter color 边缘线 颜色
     */
    public func borderLayer(rect: CGRect ,color: UIColor) {
        
        let layer = CALayer()
        
        layer.frame = rect
        layer.backgroundColor = color.cgColor
        
        self.layer.addSublayer(layer)
    }
    
    /**
     绘制边框 加圆角
     - parameter radiu 边角半径
     - parameter color 线条颜色
     - parameter lineWidth 线条宽度
     */
    public func borderLineLayer(radiu: CGFloat ,color: UIColor ,lineWidth:CGFloat) {
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        
        let borderLayer = CAShapeLayer()
        borderLayer.frame = self.bounds
        borderLayer.lineWidth = lineWidth
        borderLayer.strokeColor = color.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        
        let path = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: radiu)
        
        maskLayer.path = path.cgPath
        borderLayer.path = path.cgPath
        
        self.layer.insertSublayer(borderLayer, at: 0)
        self.layer.mask = maskLayer
    }
}
