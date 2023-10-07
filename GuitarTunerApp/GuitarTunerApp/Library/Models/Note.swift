//
//  Note.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 04.10.2023.
//


/// Note data
struct Note: Equatable {
    /// Frequency of note in Hz
    let frequency: Double
    
    /// Name of note
    let name: String
    
    static func ==(lhs: Note, rhs: Note) -> Bool {
        return lhs.frequency == rhs.frequency && lhs.name == rhs.name
    }
}
