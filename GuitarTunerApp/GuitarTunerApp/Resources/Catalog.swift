//
//  Catalog.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 08.10.2023.
//

import Foundation

enum Catalog {
    enum Names {
        static let low: String = "Low"
        static let hieght: String = "High"
        static let tuner: String = "Tuner"
        static let auto: String = "Auto"
        
        static func frequencyTitleFrom(_ frequency: Double) -> String {
            "\(String(format: "%.1f", frequency)) Hz"
        }
    }
}
