//
//  Instruments.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 04.10.2023.
//


/// Available instruments
enum Instruments {
    case guitar6String
}

extension Instruments {
    /**
     Give instrument notes setting
     
     - Returns: Notes for picked instrument
     */
    func getNotes() -> Notes {
        switch self {
        case .guitar6String:
            return [Note(frequency: 82.41, name: "E-6"),
                    Note(frequency: 110.00, name: "A-5"),
                    Note(frequency: 146.82, name: "D-4"),
                    Note(frequency: 196.00, name: "G-3"),
                    Note(frequency: 246.94, name: "B-2"),
                    Note(frequency: 329.63, name: "e-1")]
        }
    }
}
