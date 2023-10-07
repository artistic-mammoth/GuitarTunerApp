//
//  TunerPresenterImpl.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 05.10.2023.
//

import Foundation

final class TunerPresenterImpl {
    // MARK: - Public properties
    weak var view: TunerView?
    
    // MARK: - Private properties
    private var tuner: Tuner
    
    private var data: Notes = Instruments.guitar6String.getNotes()
    private var currentNote: (index: Int, note: Note)?
    private var isAutoMode: Bool = false {
        didSet { resetAutoMode() }
    }
    
    private var timer: Timer?
    private var isCurrentComplete: Bool?
    private var completionApproveCount: Int = 0
    private var currentOffset: Double = 0
    
    // MARK: - Init
    init(view: TunerView? = nil, tuner: Tuner) {
        self.view = view
        self.tuner = tuner
        setupTuner()
    }
}

// MARK: - TunerPresenter
extension TunerPresenterImpl: TunerPresenter {
    func viewDidLoaded() {
        let guitarNotes = Instruments.guitar6String.getNotes()
        view?.setupNotesPreset(notes: guitarNotes)
    }
    
    func setCurrentNote(at index: Int) {
        currentNote = (index, data[index])
    }
    
    func setAutoMode(isEnabled: Bool) {
        isAutoMode = isEnabled
    }
}

// MARK: - Private extension
private extension TunerPresenterImpl {
    func setupTuner() {
        tuner.startDetecting()
        tuner.dataHandler = { [weak self] frequency in
            DispatchQueue.main.async {
                self?.calculateTunerWith(frequency)
            }
        }
    }
    
    func calculateTunerWith(_ currentfrequency: Double) {
        let closest = data.findClosestTo(currentfrequency)

        if isAutoMode {
            let offset = currentfrequency - closest.note.frequency
            view?.updateOffset(offset)
            view?.updateCurrentfrequency(currentfrequency)
            view?.selectNoteAt(closest.index)
            currentNote = (closest.index, closest.note)
            currentOffset = offset
        } else if let currentNote = currentNote {
            let offset = currentfrequency - currentNote.note.frequency
            view?.updateOffset(offset)
            view?.updateCurrentfrequency(currentfrequency)
            currentOffset = offset
        }
        
        approveCompleted()
    }
    
    func approveCompleted() {
        if timer != nil { return }
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        timer?.tolerance = 0.1
    }
    
    @objc
    func timerAction() {
        if abs(currentOffset) > 4 {
            isCurrentComplete = false
            timer?.invalidate()
            timer = nil
            completionApproveCount = 0
        } else {
            isCurrentComplete = true
            completionApproveCount += 1
            if completionApproveCount > 3 {
                if let index = currentNote?.index {
                    view?.setNoteCompleteAt(index)
                }
                completionApproveCount = 0
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    func resetAutoMode() {
        view?.updateOffset(0)
        view?.deselectAllNotes()
    }
}
