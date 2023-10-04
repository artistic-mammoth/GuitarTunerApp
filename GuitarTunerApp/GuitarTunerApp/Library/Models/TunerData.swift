//
//  TunerData.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 04.10.2023.
//


/**
 Data what returns from Tuner.
 
 Contains note reference and offset in Hz to this note
 */
struct TunerData {
    /// Picked Note to compare
    var currentNote: Note = Note(frequency: 0, name: "-")
    
    /// Offset in Hz to currentNote
    var offset: Double = 0
}
