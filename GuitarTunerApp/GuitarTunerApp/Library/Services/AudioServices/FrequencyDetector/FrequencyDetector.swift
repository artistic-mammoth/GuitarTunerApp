//
//  FrequencyDetector.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 04.10.2023.
//

import AudioKit

// Detector of input frequency
protocol FrequencyDetector {
    /// Handler for changed of frequency
    var frequencyHandler: ((Double) -> ())? { get set }
    
    /**
     Start of detection for microphone
     
     - Parameters:
        - microphone: input microphone to detect
     */
    func startTracker(with microphone: AudioEngine.InputNode)
    
    /// Stop detection
    func stopTracker()
}
