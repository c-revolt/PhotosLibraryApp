//
//  FavoritePhotoCell.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 12.05.2023.
//

import UIKit
import SDWebImage

class FavoritePhotoCell: UICollectionViewCell {
    
    let photoImageView: UIImageView = UIImageView()
    let checkmark: UIImageView = UIImageView()
    
    static let reusedID = "FavoritesCell"
    
    weak var viewModel: FavoritePhotoCellViewModelType? {
        willSet(viewModel) {
            guard let photoUrl = viewModel?.photoString else { fatalError() }
            let url = URL(string: photoUrl)
            photoImageView.sd_setImage(with: url)
            photoImageView.image = UIImage(named: photoUrl)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateSelectedState()
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    private func updateSelectedState() {
        photoImageView.alpha = isSelected ? 0.7 : 1
        checkmark.alpha = isSelected ? 1 : 0
    }
    
    private func setup() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.backgroundColor = .systemBackground
        photoImageView.contentMode = .scaleAspectFill
        
        checkmark.translatesAutoresizingMaskIntoConstraints = false
        checkmark.image = UIImage(systemName: "checkmark.circle.fill")
        checkmark.alpha = 0

        addSubview(photoImageView)
        addSubview(checkmark)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            checkmark.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8),
            checkmark.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 8)
        ])
    }
}
