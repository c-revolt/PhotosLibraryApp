//
//  FavoritesViewController.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 12.04.2023.
//

import UIKit

protocol FavoritesViewControllerType: AnyObject {
    
}

class FavoritesViewController: UIViewController {
    
    var photos: [Photo] = []
    var collectionView: UICollectionView?
    var viewModel: FavoritesViewViewModelType?
    private let enterSearchTermLabel: UILabel = UILabel()
    
    private lazy var trashBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
    }()
    
    init(viewModel: FavoritesViewViewModelType? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupViews()
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
    
    private func setupViews() {
        
        enterSearchTermLabel.text = "Вы ещё не добавили сюда фото..."
        enterSearchTermLabel.textAlignment = .center
        enterSearchTermLabel.font = UIFont.boldSystemFont(ofSize: 20)
        enterSearchTermLabel.translatesAutoresizingMaskIntoConstraints = false
        
        guard let collectionView = collectionView else { return }
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        enterSearchTermLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 50).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = "FAVORITES"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .darkText
        trashBarButtonItem.tintColor = .systemTeal
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        navigationItem.rightBarButtonItems = [trashBarButtonItem]
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

extension FavoritesViewController: FavoritesViewControllerType {
    
}
