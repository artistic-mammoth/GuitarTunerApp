//
//  NotePickerDelegate.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 06.10.2023.
//

/// Delegate for NotePickerView.
protocol NotePickerDelegate: AnyObject {
    /**
     Callback when item is picked.
     
     - Parameters:
        - index: Index of item.
     */
    func didSelectItemAt(_ index: Int)
}
