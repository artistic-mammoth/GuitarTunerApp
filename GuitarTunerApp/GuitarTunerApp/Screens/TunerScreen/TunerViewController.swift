//
//  TunerViewController.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 03.10.2023.
//

import UIKit

// TODO: Refactor test template
class TunerViewController: UIViewController {
    var tuner: Tuner = TunerBuilder.build()
    
    lazy var noteLabel: UILabel = {
        return $0
    }(UILabel())
    
    lazy var frequencyOffsetLabel: UILabel = {
        return $0
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTuner()
        setupView()
    }
    
    func setupTuner() {
        let guitarNotes = Instruments.guitar6String.getNotes()
        tuner.setupNotes(guitarNotes)
        tuner.startDetecting()
        tuner.dataHandler = { data in
            DispatchQueue.main.async {
                self.noteLabel.text = data.currentNote.name
                self.frequencyOffsetLabel.text = String(format: "%.1f", data.offset)
            }
            print(data)
        }
    }
    
    func setupView() {
        view.addSubview(noteLabel)
        view.addSubview(frequencyOffsetLabel)
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        frequencyOffsetLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noteLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -15),
            
            frequencyOffsetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            frequencyOffsetLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 15),
        ])
    }
}
