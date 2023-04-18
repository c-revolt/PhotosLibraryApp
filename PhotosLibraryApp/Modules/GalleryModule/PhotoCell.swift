//
//  PhotoCell.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 18.04.2023.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let reusedID = K.photoCellReusedID
    
    private let checkmark: UIImageView = {
        let image = UIImage(named: "checkmark")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateSelectedState()
        setupViews()
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
    
    private func setupViews() {
        addSubview(photoImageView)
        addSubview(checkmark)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            checkmark.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8),
            checkmark.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 8)
        
        ])
    }
}
