//
//  TunerPresenter.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 08.10.2023.
//

/// Tuner presenter
protocol TunerPresenter {
    /**
     Set picked note with index.
     
     - Parameters:
        - index: Index of Note.
     */
    func setCurrentNote(at index: Int)
    
    /// Callback when view is loaded.
    func viewDidLoaded()
    
    /**
     Set automode.
     
     - Parameters:
        - isOn: Is automode enabled.
     */
    func setAutoMode(isEnabled: Bool)
    
    /**
     Callback from View when instrument was chosen.
     
     - Parameters:
        - instrument: Type of Instrument
     */
    func instrumentDidPicked(_ instrument: Instruments)
}
