//
//  ImageRes.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 19.10.2023.
//

import UIKit

extension UIImage {
    
    static let chevronDown: UIImage = {
        guard let icon = UIImage(systemName: "chevron.down")?
            .withTintColor(.blackMain, renderingMode: .alwaysOriginal)
            .applyingSymbolConfiguration(.init(font: .boldInter(size: 15), scale: .large)) else {
            return UIImage()
        }
        return icon
    }()
    
}
