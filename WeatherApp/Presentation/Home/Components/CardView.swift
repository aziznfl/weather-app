//
//  CardView.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 05/01/26.
//

import UIKit
import SwiftUI

class CardViewCell: UICollectionViewCell {
    static let identifier = "WidgetPreviewCell"
    
    private var hostingController: UIHostingController<CurrentWeatherCardView>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hostingController?.view.removeFromSuperview()
        hostingController = nil
    }
    
    func configure(item: WeatherCardItem) {
        let swiftUIView = CurrentWeatherCardView(
            item: item,
            backgroundImage: getBackgroundImage(),
            isWidget: false
        )
        let hostingController = UIHostingController(rootView: swiftUIView)

        self.hostingController = hostingController

        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func getBackgroundImage() -> UIImage? {
        guard let pathString = BackgroundDataSource.shared.load() else { return nil }
        return UIImage(contentsOfFile: pathString)
    }
}
