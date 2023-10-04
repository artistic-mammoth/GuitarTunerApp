//
//  TunerBuilder.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 04.10.2023.
//


// TODO: - Refactor it
class TunerBuilder {
    static func build() -> Tuner {
        let detector = FrequencyDetectorImpl()
        let input = AudioInputImpl()
        let tuner = TunerImpl(detector: detector, audioInput: input)
        return tuner
    }
}
