//
//  TunerImpl.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 04.10.2023.
//


/// Implementation of FrequencyDetector
final class TunerImpl: Tuner {
    // MARK: - Public properties
    var dataHandler: ((TunerData) -> ())?
    
    // MARK: - Private properties
    private var detector: FrequencyDetector
    private let audioInput: AudioInput
    
    private var currentNotes: Notes?
    private var data: TunerData = TunerData() {
        didSet {
            dataHandler?(data)
        }
    }
    
    // MARK: - Init
    init(detector: FrequencyDetector, audioInput: AudioInput, currentNotes: Notes? = nil) {
        self.detector = detector
        self.audioInput = audioInput
        self.currentNotes = currentNotes
    }
    
    // MARK: - Tuner
    func startDetecting() {
        let mic = audioInput.getMicrophone()
        detector.startTracker(with: mic)
        
        detector.frequencyHandler = { [weak self] frequency in
            guard let self = self else { print("No TunerImpl"); return }
            let closestNote = self.currentNotes?.findClosestTo(frequency)
            guard let closestNote = closestNote else { print("No Notes"); return }
            let offset = closestNote.frequency - frequency
            let newData = TunerData(currentNote: closestNote, offset: offset)
            self.data = newData
        }
        
        audioInput.startEngine()
    }
    
    func setupNotes(_ notes: Notes) {
        currentNotes = notes
    }
}
