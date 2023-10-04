//
//  FrequencyDetectorImpl.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 04.10.2023.
//

import AudioKit
import SoundpipeAudioKit

/// Implementation of FrequencyDetector
final class FrequencyDetectorImpl: FrequencyDetector {
    // MARK: - Public properties
    var frequencyHandler: ((Double) -> ())?
    
    // MARK: - Private properties
    private var tracker: PitchTap!
    
    // MARK: - Deinit
    deinit {
        tracker.stop()
    }
    
    // MARK: - FrequencyDetector
    func startTracker(with microphone: AudioEngine.InputNode) {
        tracker = PitchTap(microphone) { [weak self] pitch, amp in
            self?.update(pitch[0], amp[0])
        }
        tracker.start()
    }
    
    // MARK: - Private methods
    private func update(_ pitch: AUValue, _ amp: AUValue) {
        guard amp > 0.1 else { return }
        frequencyHandler?(Double(pitch))
    }
}
