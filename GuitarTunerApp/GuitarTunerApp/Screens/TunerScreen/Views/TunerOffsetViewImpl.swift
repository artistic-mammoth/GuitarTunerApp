//
//  TunerOffsetViewImpl.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 05.10.2023.
//

import UIKit

final class TunerOffsetViewImpl: UIView {
    // MARK: - Private properties
    private let labels: [String] = ["-80", "-60", "-40", "-20", "0", "20", "40", "60", "80"]
    
    // MARK: - Views
    private lazy var arrow = TunerArrowView()
    private lazy var subArrow = TunerSubArrowView()
    private lazy var rulerLayer = CAShapeLayer()
}

// MARK: - TunerOffsetView
extension TunerOffsetViewImpl: TunerOffsetView {
    func configure(in contextSize: CGSize) {
        setupView(in: contextSize)
    }
    
    func animateTo(_ offset: Double) {
        var angle = Config.getAngleFrom(offset)
        let maxAngle = Config.maxAngle
        
        if angle >= maxAngle { angle = maxAngle }
        if angle <= -maxAngle { angle = -maxAngle }
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.arrow.transform = CGAffineTransform(rotationAngle: angle)
            self?.arrow.isLow = angle < 0
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.05, options: .curveEaseOut) { [weak self] in
            self?.subArrow.transform = CGAffineTransform(rotationAngle: angle)
            self?.subArrow.isLow = angle < 0
        }
    }
}

// MARK: - Private extension
private extension TunerOffsetViewImpl {
    func setupView(in contextSize: CGSize) {
        let radius = contextSize.width / 2
        let center = CGPoint(x: radius, y: radius + 60)
        let contextRect = CGRect(origin: CGPoint(x: 0, y: 0), size: contextSize)
        
        addArrowView(in: contextRect, radius: radius, center: center)
        addRulerLayer(radius: radius, center: center)
    }
    
    func addArrowView(in contextFrame: CGRect, radius: CGFloat, center: CGPoint) {
        addSubview(subArrow)
        addSubview(arrow)
        
        subArrow.configure(radius: radius, center: center)
        arrow.configure(radius: radius, center: center)
        
        subArrow.frame = contextFrame
        arrow.frame = contextFrame
        
        let maskPath = UIBezierPath(arcCenter: CGPoint(x: center.x, y: center.y + 20),
                                    radius: radius * 0.35,
                                    startAngle: CGFloat(0),
                                    endAngle: CGFloat(Double.pi * 2),
                                    clockwise: true)
        maskPath.addArc(withCenter: center,
                        radius: radius * 1.5,
                        startAngle: CGFloat(0),
                        endAngle: CGFloat(Double.pi * 2),
                        clockwise: true)
        
        let arrowMaskLayer = CAShapeLayer()
        arrowMaskLayer.path = maskPath.cgPath
        arrowMaskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        arrow.layer.mask = arrowMaskLayer
        
        let subArrowMaskLayer = CAShapeLayer()
        subArrowMaskLayer.path = maskPath.cgPath
        subArrowMaskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        subArrow.layer.mask = subArrowMaskLayer
    }
    
    func addRulerLayer(radius: CGFloat, center: CGPoint) {
        let rulerPath = UIBezierPath(arcCenter: center,
                                     radius: radius,
                                     startAngle: 0,
                                     endAngle: Double.pi * 2,
                                     clockwise: true)
        
        rulerLayer.path = rulerPath.cgPath
        rulerLayer.fillColor = UIColor.clear.cgColor
        rulerLayer.strokeColor = UIColor.clear.cgColor
        rulerLayer.lineWidth = 6
        
        let startRulerRadius = radius - rulerLayer.lineWidth * 0.5
        let endRulerRadius = startRulerRadius + 6
        
        var angle: CGFloat = Config.startAngle
        
        for index in Config.barsCountRange {
            let barAngle = CGFloat.pi * angle
            let centerBarOffset: CGFloat = index == Config.centerBarIndex ? Config.centerBarOffset : 0
            let startRadius = startRulerRadius + centerBarOffset
            let endRadius = endRulerRadius - centerBarOffset
            
            let startBarPoint = CGPoint(
                x: cos(-barAngle) * startRadius + center.x,
                y: sin(-barAngle) * startRadius + center.y
            )
            
            let endBarPoint = CGPoint(
                x: cos(-barAngle) * endRadius + center.x,
                y: sin(-barAngle) * endRadius + center.y
            )
            
            addBarLayer(startPoint: startBarPoint, endPoint: endBarPoint)
            
            if index % 2 != 0 {
                let labelPoint = CGPoint(
                    x: cos(-barAngle) * (endRulerRadius + Config.labelOffset) + center.x,
                    y: sin(-barAngle) * (endRulerRadius + Config.labelOffset) + center.y
                )
                addRulerLabel(for: index, at: labelPoint)
            }
            
            angle -= Config.angleOffset
        }
        
        layer.addSublayer(rulerLayer)
    }
    
    func addRulerLabel(for index: Int, at point: CGPoint) {
        let label =  UILabel()
        label.textColor = .blackSecondary
        label.font = .regularInter(size: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = labels[index / 2]
        label.frame = CGRect(x: point.x - 20, y: point.y - 20, width: 40, height: 40)
        addSubview(label)
    }
    
    func addBarLayer(startPoint: CGPoint, endPoint: CGPoint) {
        let barPath = UIBezierPath()
        barPath.move(to: startPoint)
        barPath.addLine(to: endPoint)
        
        let barLayer = CAShapeLayer()
        barLayer.path = barPath.cgPath
        barLayer.fillColor = UIColor.clear.cgColor
        barLayer.strokeColor = UIColor.blackMain.cgColor
        barLayer.lineCap = .round
        barLayer.lineWidth = 4
        rulerLayer.addSublayer(barLayer)
    }
}

fileprivate enum Config {
    static let startAngle: CGFloat = 18 / 20
    static let angleOffset: CGFloat = 1 / 20
    static let barsCountRange: ClosedRange = 1...17
    static let centerBarIndex: Int = 9
    static let centerBarOffset: CGFloat = -7.0
    static let labelOffset: CGFloat = 30
    
    static let maxAngle: Double = .pi * (8 - (0.05 * 8)) / 20
    
    static func getAngleFrom(_ offset: Double) -> Double {
        .pi * ((offset / 10) - (0.05 * (offset / 10))) / 20
    }
}
