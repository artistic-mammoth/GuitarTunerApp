//
//  Tuner.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 04.10.2023.
//


/// Tuner for input detection
protocol Tuner {
    /// Handler for data of pitch and note from input device
    var dataHandler: ((TunerData) -> ())? { get set }
    
    /**
     Tracking note setting
     
     - Parameters:
     - notes: Notes for tracking
     */
    func setupNotes(_ notes: Notes)
    
    /// Start of detecting from input device
    func startDetecting()
}
