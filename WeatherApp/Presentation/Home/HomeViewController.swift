//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 30/12/25.
//

import CoreLocation
import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet internal weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var changeBackgroundButton: UIView!

    var errorView: ErrorView!
    var alertFactory: LocationPermissionAlertFactory!
    var viewModel: HomeViewModel!

    internal var items: [WeatherCardItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHeader()
        setupCollectionView()
        setupErrorView()
        bindViewModel()

        viewModel.start()
    }

    private func setupHeader() {
        title = "Weather App"
    }
    
    private func setupCollectionView() {
        let layout = CenterSnapFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 32
        layout.minimumInteritemSpacing = 32
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        
        let marginLeft = view.bounds.width - CardLayout.longestWidth
        let margin: CGFloat = marginLeft / 2
        collectionView.contentInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        
        collectionView.register(
            CardViewCell.self,
            forCellWithReuseIdentifier: CardViewCell.identifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupErrorView() {
        view.addSubview(errorView)

        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            errorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            errorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onCurrentWeatherLoaded = { [weak self] weather in
            self?.render(weather: weather)
        }

        viewModel.onError = { [weak self] error in
            self?.render(error: error)
        }
    }
    
    private func render(error: BaseError) {
        if error.statusCode == 424 {
            let alert = alertFactory.makeAlert(
                settingsHandler: goToSettings
            )
            present(alert, animated: true)

            collectionView.isHidden = true
            pageControl.isHidden = true
            changeBackgroundButton.isHidden = true
        }

        errorView.setup(label: error.message)
        errorView.isHidden = false
    }
    
    private func render(weather: Weather) {
        let locationName = "\(weather.location.name), \(weather.location.countryCode)"

        items = WeatherCardItem.makeAll(
            type: weather.type,
            location: locationName
        )

        collectionView.isHidden = false
        pageControl.isHidden = false
        changeBackgroundButton.isHidden = false
        errorView.isHidden = true

        pageControl.numberOfPages = items.count
        pageControl.currentPage = 0

        collectionView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func didTapChangeBackground(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = false
        present(picker, animated: true)
    }
    
    func goToSettings(_ action: UIAlertAction) {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
