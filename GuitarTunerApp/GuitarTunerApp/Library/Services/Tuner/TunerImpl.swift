//
//  TunerImpl.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 04.10.2023.
//


/// Implementation of Tuner
final class TunerImpl: Tuner {
    // MARK: - Public properties
    var dataHandler: ((_ frequency: Double) -> ())?
    
    // MARK: - Private properties
    private var detector: FrequencyDetector
    private let audioInput: AudioInput

    // MARK: - Init
    init(detector: FrequencyDetector, audioInput: AudioInput) {
        self.detector = detector
        self.audioInput = audioInput
    }
    
    // MARK: - Tuner
    func startDetecting() {
        let mic = audioInput.getMicrophone()
        detector.startTracker(with: mic)
        
        detector.frequencyHandler = { [weak self] frequency in
            guard let self = self else { print("No TunerImpl"); return }
            self.dataHandler?(frequency)
        }
        
        audioInput.startEngine()
    }
    
    func stopDetecting() {
        detector.stopTracker()
        detector.frequencyHandler = nil
        audioInput.stopEngine()
    }
}
