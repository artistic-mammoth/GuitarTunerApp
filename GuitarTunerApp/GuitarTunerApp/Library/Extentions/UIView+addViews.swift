//
//  UIView+addViews.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 05.10.2023.
//

import UIKit

extension UIView {
    /**
     Additing view to subviews with configuration for AutoLayout.
     - Parameters:
        - views: views to add
     */
    func addViews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
