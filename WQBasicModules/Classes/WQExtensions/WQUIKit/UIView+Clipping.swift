//
//  UIView+Clipping.swift
//  Pods
//
//  Created by WangQiang on 2018/5/18.
//

import UIKit
public extension UIView {
    /// 设置view的圆角
    ///
    /// - Parameters:
    ///   - radius: 圆角半径
    ///   - corners: 圆角位置
    func maskCorners(_ radius: CGFloat, corners: UIRectCorner = .allCorners) {
        if corners.contains(.allCorners) {
            layer.cornerRadius = radius
            layer.masksToBounds = true
        } else {
            guard self.bounds.size != .zero else {
                fatalError("设置不规则圆角必须先有尺寸")
            }
           makeRectangleCorners(CGSize(width: radius, height: radius), react: self.bounds, corners: corners)
        }
    }
    
    /// 设置方形边框
    func makeRectangleCorners(_ cornerSize: CGSize, react: CGRect, corners: UIRectCorner = .allCorners) {
        let bounds = self.bounds
        let bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: cornerSize)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = bezierPath.cgPath
        layer.mask = shapeLayer
    }
    
    /// 截屏
    func snapshot () -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
