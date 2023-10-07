//
//  NotePickerCell.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 05.10.2023.
//

import UIKit

final class NotePickerCell: UICollectionViewCell {
    // MARK: - Public properties
    /// Identifier for collection view.
    static let reuseIdentifier = "NotePickerCell"
    
    /// Tuning completion status.
    var isCompleted: Bool = false {
        didSet {
            changeApperance(isPicked: isSelected, isCompleted: isCompleted)
        }
    }
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        $0.textColor = .blackMain
        $0.font = .blackInter(size: 27)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var substrate: UIView = {
        $0.layer.borderWidth = 2
        return $0
    }(UIView())
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        substrate.layer.cornerRadius = substrate.bounds.size.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isCompleted = false
    }
    
    override var isSelected: Bool {
        didSet {
            changeApperance(isPicked: isSelected, isCompleted: isCompleted)
        }
    }
    
    // MARK: - Public methods
    /**
     Configure cell with note data.
     
     - Parameters:
        - note: Note to present.
     */
    func configureWith(note: Note) {
        titleLabel.text = "\(note.name)"
    }
}

// MARK: - Private extention
private extension NotePickerCell {
    func setupView() {
        addViews(substrate, titleLabel)
        
        changeApperance(isPicked: false, isCompleted: false)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            substrate.centerXAnchor.constraint(equalTo: centerXAnchor),
            substrate.centerYAnchor.constraint(equalTo: centerYAnchor),
            substrate.heightAnchor.constraint(equalTo: substrate.widthAnchor),
            substrate.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    func changeApperance(isPicked: Bool, isCompleted: Bool) {
        if isCompleted {
            substrate.backgroundColor = isCompleted ? .greenAccent : .blackMain
            substrate.layer.borderColor = UIColor.clear.cgColor
            titleLabel.textColor = isCompleted ? .whiteMain : .blackMain
            return
        }
        substrate.backgroundColor = isPicked ? .blackMain : .clear
        substrate.layer.borderColor = isPicked ? UIColor.clear.cgColor : UIColor.blackSecondary.cgColor
        titleLabel.textColor = isPicked ? .whiteMain : .blackMain
    }
}
