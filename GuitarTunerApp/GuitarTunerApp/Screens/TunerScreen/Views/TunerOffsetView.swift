//
//  TunerOffsetView.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 08.10.2023.
//

import UIKit

protocol TunerOffsetView: UIView {
    /**
     Configure with size.
     
     - Parameters:
        - contextSize: Size of context.
     */
    func configure(in contextSize: CGSize)
    
    /**
     Animate offset.
     
     - Parameters:
        - offset: Offset data.
     */
    func animateTo(_ offset: Double)
}
