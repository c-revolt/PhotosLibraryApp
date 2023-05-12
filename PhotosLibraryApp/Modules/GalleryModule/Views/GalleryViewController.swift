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
    private var timer: Timer?
    var viewModel: GalleryViewModelType?
    
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
    
    private var numberOfSelectedPhotos: Int {
        return collectionView?.indexPathsForSelectedItems?.count ?? 0
    }
    
    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Начни поиск, чтобы увидеть фото..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = GalleryViewModel()
        
        navigationItem.title = "Gallery"
    
        updateNavButtonState()
        setupNavigationBar()
        setupCollectionView()
        setupSearchBar()
        setupEnterLabel()
        setupSpinner()
        
    }
    
    override func viewDidLayoutSubviews() {
        collectionView?.frame = view.bounds
    }
    
    private func updateNavButtonState() {
        addBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
        sharedBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
    }
    
    func refresh() {
        self.viewModel?.selectedImages.removeAll()
        self.collectionView?.selectItem(at: nil, animated: true, scrollPosition: [])
        updateNavButtonState()
    }
    
    // MARK: - Setup UI Elements
    private func setupCollectionView() {
        let layout = WaterfallLayout()
        layout.delegate = self
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(GalleryPhotoCell.self, forCellWithReuseIdentifier: GalleryPhotoCell.reusedID)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .systemBackground
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "PHOTOS"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .darkText
        sharedBarButtonItem.tintColor = .systemTeal
        addBarButtonItem.tintColor = .systemTeal
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
    
    private func setupEnterLabel() {
        guard let collectionView = collectionView else { return }
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        enterSearchTermLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 50).isActive = true
    }
    
    private func setupSpinner() {
        guard let collectionView = collectionView else { return }
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
    }
}

// MARK: - UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfRows = viewModel?.numberOfRows() else { fatalError() }
        enterSearchTermLabel.isHidden = numberOfRows != 0
        return numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryPhotoCell.reusedID,
            for: indexPath) as? GalleryPhotoCell else { return UICollectionViewCell() }
        
        guard let viewModel = viewModel else { fatalError() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GalleryViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateNavButtonState()
        guard let cell = collectionView.cellForItem(at: indexPath) as? GalleryPhotoCell else { return }
        guard let image = cell.photoImageView.image else { return }
        viewModel?.appendSelectedImages(image)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        updateNavButtonState()
        guard let cell = collectionView.cellForItem(at: indexPath) as? GalleryPhotoCell else { return }
        guard let image = cell.photoImageView.image else { return }
        viewModel?.removeSelectedImages(image)
    }
}

// MARK: - UISearchBarDelegate
extension GalleryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        guard let collectionView = collectionView else { return }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.viewModel?.fetchResults(text: searchText, collectionView: collectionView)
            self.spinner.stopAnimating()
            self.refresh()
        })
    }
}

// MARK: - NavigationItems Actions
extension GalleryViewController {
    @objc private func addBarButtonTapped() {
        print(#function)
        
        let selectedPhotos = collectionView?.indexPathsForSelectedItems?.reduce([], { (photosss, indexPath) -> [Photo] in
            var mutablePhotos = photosss
            guard let photo2 = viewModel?.getPhotosForAddBarButton(forIndexPath: indexPath) else { fatalError() }
            mutablePhotos.append(photo2)
            return mutablePhotos
        })
        
        let alertController = UIAlertController(title: "",
                                                message: "\(String(describing: selectedPhotos?.count)) фото будут добавлены в альбом",
                                                preferredStyle: .alert)
        let add = UIAlertAction(title: "Добавить", style: .default) { (action) in
            let tabbar = self.tabBarController as! MainTabBarController
            let navVC = tabbar.viewControllers?[1] as! UINavigationController
            let favoritesVC = navVC.topViewController as! FavoritesViewController
            
            favoritesVC.viewModel?.appendSelectedImages(selectedPhotos ?? [])
            guard let collectionView = self.collectionView else { return }
            favoritesVC.viewModel?.reloadDataForAddBarButton(collectionView)
            
            self.refresh()
        }
        let cancel = UIAlertAction(title: "Отменить", style: .cancel) { (action) in }
        alertController.addAction(add)
        alertController.addAction(cancel)
        present(alertController, animated: true)
        
    }
    
    @objc private func sharedBarButtonTapped(sender: UIBarButtonItem) {
        print(#function)
        
        let shareController = UIActivityViewController(activityItems: viewModel!.selectedImages, applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                self.refresh()
            }
        }
        
        shareController.popoverPresentationController?.barButtonItem = sender
        shareController.popoverPresentationController?.permittedArrowDirections = .any
        
        present(shareController, animated: true)
    }
}

extension GalleryViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let viewModel = viewModel else { fatalError() }
        return viewModel.waterFallLayout(for: indexPath)
    }
}
