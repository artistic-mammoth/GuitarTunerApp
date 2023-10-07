//
//  Notes.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 04.10.2023.
//


/// Representation of notes array
typealias Notes = [Note]

extension Notes {
    /**
     Find closest note for current frequency
     
     - Parameters:
        - inputFrequency: input of Hz
        - Returns: Finded note
     */
    func findClosestTo(_ inputFrequency: Double) -> (index: Int, note: Note) {
        let closest = (self.reduce(self[0]) { abs($0.frequency - inputFrequency) < abs($1.frequency - inputFrequency) ? $0 : $1 })
        let index = self.firstIndex { $0 == closest }!
        return (index, closest)
    }
}
