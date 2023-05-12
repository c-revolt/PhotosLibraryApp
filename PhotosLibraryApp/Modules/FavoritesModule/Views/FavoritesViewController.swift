//
//  FavoritesViewController.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 12.04.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    var viewModel: FavoritesViewViewModelType?
    
    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "You haven't add a photos yet"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trashBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FavoritesViewViewModel()
        setupCollectionView()
        setupEnterLabel()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView?.frame = view.bounds
    }
    
    // MARK: - Setup UI Elements
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(FavoritePhotoCell.self, forCellWithReuseIdentifier: FavoritePhotoCell.reusedID)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func setupEnterLabel() {
        guard let collectionView = collectionView else { return }
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        enterSearchTermLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 50).isActive = true
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel(text: "FAVOURITES", font: .systemFont(ofSize: 15, weight: .medium), textColor: #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        navigationItem.rightBarButtonItem = trashBarButtonItem
        trashBarButtonItem.isEnabled = false
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfRows = viewModel?.numberOfRows() else { fatalError() }
        return numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritePhotoCell.reusedID, for: indexPath) as? FavoritePhotoCell else { return UICollectionViewCell() }
        
        guard let viewModel = viewModel else { fatalError() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width/3 - 1, height: width/3 - 1)
    }
}
