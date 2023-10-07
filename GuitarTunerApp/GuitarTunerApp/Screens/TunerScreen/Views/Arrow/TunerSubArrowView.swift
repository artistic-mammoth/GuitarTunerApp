//
//  TunerSubArrowView.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 05.10.2023.
//

import UIKit

final class TunerSubArrowView: UIView {
    // MARK: - Public properties
    /// Offset is below zero.
    var isLow: Bool = false {
        didSet {
            color = isLow ? .redSecondary : .greenSecondary
        }
    }
    
    // MARK: - Private properties
    private var color: UIColor = .greenSecondary {
        didSet { changeColor() }
    }
    
    private let subArrowShape = CAShapeLayer()
    
    // MARK: - Public methods
    /**
     Configure view with parameters.
     - Parameters:
        - radius: radius of ruler.
        - center: center point.
     */
    func configure(radius: CGFloat, center: CGPoint) {
        let subArrowPath = getSubArrowPath(radius: radius, center: center)
        subArrowShape.path = subArrowPath.cgPath
        setApperance()
        layer.addSublayer(subArrowShape)
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.75)
    }
}

// MARK: - Private extention
private extension TunerSubArrowView {
    func changeColor() {
        subArrowShape.fillColor = color.cgColor
    }
    
    func setApperance() {
        subArrowShape.fillColor = color.cgColor
    }
    
    func getSubArrowPath(radius: CGFloat, center: CGPoint) -> UIBezierPath {
        let leftangle = CGFloat.pi * 12.3 / 20
        let rightangle = CGFloat.pi * 7.7 / 20
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: center.x - 15, y: center.y))
        path.addLine(to: CGPoint(
            x: cos(-leftangle) * (radius + 13) + center.x,
            y: sin(-leftangle) * (radius + 13) + center.y
        ))
        path.addQuadCurve(to: CGPoint(
            x: cos(-rightangle) * (radius + 13) + center.x,
            y: sin(-rightangle) * (radius + 13) + center.y
        ), controlPoint: CGPoint(x:radius, y: center.y - radius - 27))
        
        path.addLine(to: CGPoint(x: center.x + 15, y: center.y))
        path.addLine(to: CGPoint(x: center.x - 15, y: center.y))
        return path
    }
}
