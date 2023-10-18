//
//  TunerView.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 08.10.2023.
//

import UIKit

/// Tuner View
protocol TunerView: UIViewController {
    /**
     Update current detected frequency.
     
     - Parameters:
        - frequency: Frequency amount.
     */
    func updateCurrentfrequency(_ frequency: Double)
    
    /**
     Update offset.
     
     - Parameters:
        - offset: Offset amount.
     */
    func updateOffset(_ offset: Double)
    
    /**
     Set notes preset.
     
     - Parameters:
        - notes: Notes to set.
     */
    func setupNotesPreset(notes: Notes)
    
    /**
     Set note as completed at index.
     
     - Parameters:
        - index: Index of note.
     */
    func setNoteCompleteAt(_ index: Int)
    
    /**
     Manual select note at index.
     
     - Parameters:
        - index: Index of note.
     */
    func selectNoteAt(_ index: Int)
    
    /// Deselect all notes.
    func deselectAllNotes()
    
    /**
     Select available instruments to choose from.
     
     - Parameters:
        - items: Array of instruments.
     */
    func updateInstrumentMenu(_ items: [Instruments])
}
