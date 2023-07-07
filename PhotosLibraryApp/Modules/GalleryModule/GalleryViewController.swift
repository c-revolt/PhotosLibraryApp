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
    var viewModel: GalleryViewViewModel
    
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
    
    private let enterSearchTermLabel: UILabel = UILabel()
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // lifecicle
    init(viewModel: GalleryViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNavButtonState()
        setupCollectionView()
        setup()
        layout()
        
    }
    
    override func viewDidLayoutSubviews() {
        collectionView?.frame = view.bounds
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
    
    private func setup() {
        guard let collectionView = collectionView else { return }
        
        view.addSubview(spinner)
        collectionView.addSubview(enterSearchTermLabel)
        
        enterSearchTermLabel.text = "Начни поиск, чтобы увидеть фото..."
        enterSearchTermLabel.textAlignment = .center
        enterSearchTermLabel.font = UIFont.boldSystemFont(ofSize: 20)
        enterSearchTermLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        let titleLabel = UILabel()
        titleLabel.text = "PHOTOS"
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .darkText
        sharedBarButtonItem.tintColor = .systemTeal
        addBarButtonItem.tintColor = .systemTeal
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        navigationItem.rightBarButtonItems = [sharedBarButtonItem, addBarButtonItem]
        
    }
    
    private func layout() {
        guard let collectionView = collectionView else { return }
        
        NSLayoutConstraint.activate([
            enterSearchTermLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            enterSearchTermLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 50),
            spinner.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = viewModel.numberOfRows() != 0
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GalleryPhotoCell.reusedID,
            for: indexPath
        )
                as? GalleryPhotoCell else { return UICollectionViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GalleryViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.appendSelectedImages(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        updateNavButtonState()
        guard let cell = collectionView.cellForItem(at: indexPath) as? GalleryPhotoCell else { return }
        guard let image = cell.photoImageView.image else { return }
       // viewModel.removeSelectedImages(image)
    }
}

// MARK: - UISearchBarDelegate
extension GalleryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.viewModel.fetchResults(text: searchText)
            self.spinner.stopAnimating()
            self.refresh()
        })
    }
}

// MARK: - NavigationItems Actions
extension GalleryViewController {
    @objc private func addBarButtonTapped() {
        showAddFavoriteAlert()
    }
    
    @objc private func sharedBarButtonTapped(_ sender: UIBarButtonItem) {
        showSharedSheet(sender)
    }
}

// MARK: - WaterfallLayoutDelegate
extension GalleryViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.waterFallLayout(for: indexPath)
    }
}

// MARK: - GalleryViewInput
extension GalleryViewController: GalleryViewInput {
    func showSharedSheet(_ sender: AnyObject) {
        
        let selectedPhotos = viewModel.selectedImages
        
        let shareController = UIActivityViewController(activityItems: selectedPhotos, applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                self.refresh()
            }
        }
        
        shareController.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        shareController.popoverPresentationController?.permittedArrowDirections = .any
        
        present(shareController, animated: true)
        
    }
    
    func showAddFavoriteAlert() {
        let selectedPhotos = viewModel.selectedImages
        
        let alertController = UIAlertController(
            title: "",
            message: "\(String(describing: selectedPhotos.count)) фото будут добавлены в альбом",
            preferredStyle: .alert
        )
        
        let add = UIAlertAction(title: "Добавить", style: .default) { (action) in
            guard let tabBar =  self.tabBarController,
                    let navVC = tabBar.viewControllers?[1] as? UINavigationController,
                    let favoritesVC = navVC.topViewController as? FavoritesViewController else { return }
            
            favoritesVC.viewModel?.appendSelectedImages(selectedPhotos)
            guard let collectionView = self.collectionView else { return }
            favoritesVC.viewModel?.reloadDataForAddBarButton(collectionView)
        }
        
        let cancel = UIAlertAction(title: "Отменить", style: .cancel) { (action) in }
        alertController.addAction(add)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
    func reloadCollection() {
        collectionView?.reloadData()
    }
    

    func updateNavButtonState() {
        addBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
        sharedBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
    }
    
    func refresh() {
        self.viewModel.selectedImages.removeAll()
        self.collectionView?.selectItem(at: nil, animated: true, scrollPosition: [])
        updateNavButtonState()
    }
}
