//
//  NotePickerViewImpl.swift
//  GuitarTunerApp
//
//  Created by Михайлов Александр on 05.10.2023.
//

import UIKit

final class NotePickerViewImpl: UIView, NotePickerView {
    // MARK: - Public properties
    weak var delegate: NotePickerDelegate?
    
    var data: Notes = [] {
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - Views
    private var collectionView: UICollectionView!
    
    // MARK: - Init
    @available (*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    init(delegate: NotePickerDelegate? = nil) {
        super.init(frame: .zero)
        
        let layout = createCollectionViewLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        self.delegate = delegate
        setupView()
    }
    
    // MARK: - NotePickerView
    func setNoteCompleteAt(_ index: Int) {
        let cell = collectionView.cellForItem(at: .init(item: index, section: 0)) as? NotePickerCell
        cell?.isCompleted = true
    }
    
    func selectNoteAt(_ index: Int) {
        collectionView.selectItem(at: .init(item: index, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
    
    func deselectAll() {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            for indexPath in selectedItems {
                collectionView.deselectItem(at: indexPath, animated: false)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension NotePickerViewImpl: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotePickerCell.reuseIdentifier, for: indexPath) as? NotePickerCell else { fatalError("Cannot get cell of type NotePickerCell") }
        
        cell.configureWith(note: data[indexPath.row])
        return cell
    }
}

// MARK: - Private extension
private extension NotePickerViewImpl {
    func setupView() {
        addViews(collectionView)
        
        configureCollectionView()
        
        backgroundColor = .clear
        collectionView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(NotePickerCell.self, forCellWithReuseIdentifier: NotePickerCell.reuseIdentifier)
    }
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = .init(top: 0, leading: 3, bottom: 0, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(1/3)),
            subitem: item, count: 3)
        
        group.contentInsets = .init(top: 0, leading: 0, bottom: 3, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .none
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
