//
//  NotePickerView.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 07.10.2023.
//

import UIKit

/// Note picker view to present notes data and implement choosing functionality.
protocol NotePickerView: UIView {
    /**
     Delegate to callback.

     - Important: Make this var is **week** to avoid retain cycle.
     */
    var delegate: NotePickerDelegate? { get set }
    
    /// Notes data to present.
    var data: Notes { get set }
    
    /**
     Setup note as completed at index.
     
     - Parameters:
        - index: Index of Note.
     */
    func setNoteCompleteAt(_ index: Int)
    
    /**
     Select  note at index.
     
     - Parameters:
        - index: Index of Note.
     */
    func selectNoteAt(_ index: Int)
    
    /// Deselect all notes.
    func deselectAll()
}
