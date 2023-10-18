//
//  TunerViewImpl.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 03.10.2023.
//

import UIKit

// TODO: Refactor test template
class TunerViewImpl: UIViewController {
    // MARK: - Public properties
    var presenter: TunerPresenter?
    
    // MARK: - Private properties
    private var notePickerView: NotePickerView
    private var tunerOffsetView: TunerOffsetView
    
    // MARK: - Views
    private lazy var lowHightLabel: UILabel = {
        $0.textColor = .blackMain
        $0.font = .mediumInter(size: 60)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var frequencyCurrentLabel: UILabel = {
        $0.textColor = .blackSecondary
        $0.font = .mediumInter(size: 16)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.text = Catalog.Names.frequencyTitleFrom(0)
        return $0
    }(UILabel())
    
    private lazy var tunerLabel: UILabel = {
        $0.text = Catalog.Names.tuner
        $0.textColor = .blackMain
        $0.font = .boldInter(size: 25)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var autoModeLabel: UILabel = {
        $0.textColor = .blackMain
        $0.font = .mediumInter(size: 17)
        $0.numberOfLines = 0
        $0.textAlignment = .right
        return $0
    }(UILabel())
    
    private lazy var autoModeTrigger: UISwitch = {
        return $0
    }(UISwitch())
    
    private lazy var instrumentLabel: UILabel = {
        $0.textColor = .blackMain
        $0.font = .mediumInter(size: 17)
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.isUserInteractionEnabled = false
        return $0
    }(UILabel())
    
    private lazy var instrumentArrowIcon: UIImageView = {
        $0.image = .chevronDown
        $0.isUserInteractionEnabled = false
        return $0
    }(UIImageView())
    
    private lazy var instrumentButton: UIButton = {
        $0.backgroundColor = .clear
        $0.showsMenuAsPrimaryAction = true
        return $0
    }(UIButton())
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    init(notePickerView: NotePickerView, tunerOffsetView: TunerOffsetView) {
        self.notePickerView = notePickerView
        self.tunerOffsetView = tunerOffsetView
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }
}

// MARK: - TunerView
extension TunerViewImpl: TunerView {
    func updateCurrentfrequency(_ frequency: Double) {
        frequencyCurrentLabel.text = Catalog.Names.frequencyTitleFrom(frequency)
    }
    
    func updateOffset(_ offset: Double) {
        tunerOffsetView.animateTo(offset)
        lowHightLabel.text = offset < 0 ? Catalog.Names.low : Catalog.Names.hieght
    }
    
    func setupNotesPreset(notes: Notes) {
        notePickerView.data = notes
    }
    
    func setNoteCompleteAt(_ index: Int) {
        notePickerView.setNoteCompleteAt(index)
    }
    
    func selectNoteAt(_ index: Int) {
        notePickerView.selectNoteAt(index)
    }
    
    func deselectAllNotes() {
        notePickerView.deselectAll()
    }
    
    func updateInstrumentMenu(_ items: [Instruments]) {
        instrumentLabel.text = items.first?.getName()
        let actions = items.map { item in
            UIAction(title: item.getName()) { [weak self] _ in
                self?.instrumentLabel.text = item.getName()
                self?.presenter?.instrumentDidPicked(item)
            } }
        instrumentButton.menu = UIMenu(title: "Instruments", children: actions)
    }
}

// MARK: - NotePickerDelegate
extension TunerViewImpl: NotePickerDelegate {
    func didSelectItemAt(_ index: Int) {
        presenter?.setCurrentNote(at: index)
    }
}

// MARK: - Private extension
private extension TunerViewImpl {
    func setupView() {
        view.addViews(tunerLabel, notePickerView, frequencyCurrentLabel, lowHightLabel, tunerOffsetView, autoModeTrigger, autoModeLabel, instrumentButton)
        instrumentButton.addViews(instrumentLabel, instrumentArrowIcon)
        
        view.backgroundColor = .whiteMain
        lowHightLabel.text = Catalog.Names.low
        autoModeLabel.text = Catalog.Names.auto
        
        notePickerView.delegate = self
        
        let context = CGSize(width: UIScreen.main.bounds.width - 100,
                             height: UIScreen.main.bounds.width - 100)
        tunerOffsetView.configure(in: context)
        
        autoModeTrigger.addTarget(self, action: #selector(switchValueDidChange), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            tunerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tunerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            notePickerView.bottomAnchor.constraint(equalTo: tunerLabel.topAnchor, constant: -30),
            notePickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            notePickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            notePickerView.heightAnchor.constraint(equalToConstant: 250),
            
            frequencyCurrentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            frequencyCurrentLabel.bottomAnchor.constraint(equalTo: notePickerView.topAnchor, constant: -40),
            
            lowHightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lowHightLabel.bottomAnchor.constraint(equalTo: frequencyCurrentLabel.topAnchor, constant: -4),
            
            tunerOffsetView.bottomAnchor.constraint(equalTo: lowHightLabel.topAnchor, constant: -15),
            tunerOffsetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tunerOffsetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            tunerOffsetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
                        
            autoModeTrigger.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            autoModeTrigger.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            autoModeLabel.centerYAnchor.constraint(equalTo: autoModeTrigger.centerYAnchor),
            autoModeLabel.trailingAnchor.constraint(equalTo: autoModeTrigger.leadingAnchor, constant: -10),
            
            instrumentButton.centerYAnchor.constraint(equalTo: autoModeTrigger.centerYAnchor),
            instrumentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instrumentButton.trailingAnchor.constraint(equalTo: instrumentArrowIcon.trailingAnchor, constant: 10),
            instrumentButton.heightAnchor.constraint(equalToConstant: 30),
            
            instrumentLabel.centerYAnchor.constraint(equalTo: instrumentButton.centerYAnchor),
            instrumentLabel.leadingAnchor.constraint(equalTo: instrumentButton.leadingAnchor, constant: 10),
            
            instrumentArrowIcon.leadingAnchor.constraint(equalTo: instrumentLabel.trailingAnchor, constant: 5),
            instrumentArrowIcon.centerYAnchor.constraint(equalTo: instrumentButton.centerYAnchor),
        ])
        
    }
    
    @objc
    func switchValueDidChange(sender: UISwitch) {
        presenter?.setAutoMode(isEnabled: sender.isOn)
    }
}
