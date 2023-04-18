//
//  GalleryViewController.swift
//  PhotosLibraryApp
//
//  Created by Александр Прайд on 12.04.2023.
//

import UIKit

class GalleryViewController: UIViewController {

    // properties
    private var collectionView: UICollectionView?
    var networkDataFetcher = NetworkDataFetcher()
    private var timer: Timer?
    private var photos = [Photo]()
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add,
                               target: self,
                               action: #selector(addBarButtonTapped))
    }()
    
    private lazy var sharedBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .action,
                               target: self,
                               action: #selector(sharedBarButtonTapped))
    }()
    
    // lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        navigationItem.title = "Gallery"
    
        setupNavigationBar()
        createCollectionView()
        setupSearchBar()
        
    }
    
    override func viewDidLayoutSubviews() {
        collectionView?.frame = view.bounds
    }
    
    // MARK: - Setup UI Elements
    private func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reusedID)
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "PHOTOS"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .lightText
        sharedBarButtonItem.tintColor = .lightText
        addBarButtonItem.tintColor = .lightText
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        navigationItem.rightBarButtonItems = [sharedBarButtonItem, addBarButtonItem]
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self 
    }
}

// MARK: - UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCell.reusedID,
            for: indexPath
        ) as? PhotoCell else { return UICollectionViewCell() }
        
        let data = photos[indexPath.item]
        cell.unsplashPhoto = data
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GalleryViewController: UICollectionViewDelegate {
    
}

// MARK: - UISearchBarDelegate
extension GalleryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.networkDataFetcher.fetchImages(searchTerm: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.photos = fetchedPhotos.results
                
                self?.collectionView?.reloadData()
            }
        })
    }
}

// MARK: - NavigationItems Actions
extension GalleryViewController {
    @objc private func addBarButtonTapped() {
        print(#function)
    }
    
    @objc private func sharedBarButtonTapped() {
        print(#function)
    }
}

