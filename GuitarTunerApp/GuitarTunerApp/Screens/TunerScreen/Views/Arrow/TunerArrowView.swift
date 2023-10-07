//
//  TunerArrowView.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 05.10.2023.
//

import UIKit

final class TunerArrowView: UIView {
    // MARK: - Public properties
    /// Offset is below zero.
    var isLow: Bool = false {
        didSet {
            color = isLow ? .redAccent : .greenAccent
        }
    }
    
    // MARK: - Private properties
    private var color: UIColor = .greenAccent {
        didSet { changeColor() }
    }
    
    private let arrowShape = CAShapeLayer()
    
    // MARK: - Public methods
    /**
     Configure view with parameters.
     - Parameters:
        - radius: radius of ruler.
        - center: center point.
     */
    func configure(radius: CGFloat, center: CGPoint) {
        let arrowPath = getArrowPath(radius: radius, center: center)
        arrowShape.path = arrowPath.cgPath
        setApperance()
        layer.addSublayer(arrowShape)
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.75)
    }
}

// MARK: - Private extention
private extension TunerArrowView {
    func changeColor() {
        arrowShape.fillColor = color.cgColor
        arrowShape.shadowColor = color.cgColor
    }
    
    func setApperance() {
        arrowShape.fillColor = color.cgColor
        arrowShape.shadowColor = color.cgColor
        arrowShape.shadowRadius = 10
        arrowShape.shadowOffset = CGSize(width: 0, height: 10)
        arrowShape.shadowOpacity = 0.8
    }
    
    func getArrowPath(radius: CGFloat, center: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: center.x - 10, y: center.y))
        path.addArc(withCenter: CGPoint(x:radius, y: radius - 60), radius: 2, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 2, clockwise: true)
        path.addLine(to: CGPoint(x: center.x + 10, y: center.y))
        path.addLine(to: CGPoint(x: center.x - 10, y: center.y))
        return path
    }
}
