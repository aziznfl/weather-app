//
//  HomeViewController+ImagePicker.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 06/01/26.
//

import UIKit
import WidgetKit

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        picker.dismiss(animated: true)

        if let imageUrl = info[.imageURL] as? URL,
           let appGroupUrl = persistImageToAppGroup(from: imageUrl) {
            BackgroundDataSource.shared.save(appGroupUrl.path)
            
            // reload
            collectionView.reloadData()
            if #available(iOS 14.0, *) {
                WidgetCenter.shared.reloadTimelines(ofKind: weatherWidgetKey)
            }
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    private func persistImageToAppGroup(from tempURL: URL) -> URL? {
        let fm = FileManager.default
        
        guard
            let containerURL = fm.containerURL(
                forSecurityApplicationGroupIdentifier: groupAppName
            ),
            let originalImage = UIImage(contentsOfFile: tempURL.path)
        else { return nil }

        let imagesDir = containerURL.appendingPathComponent("Backgrounds")
        do {
            try fm.createDirectory(
                at: imagesDir,
                withIntermediateDirectories: true
            )
            
            let filename = "background_\(Int(Date().timeIntervalSince1970)).jpg"
            let destinationURL = imagesDir.appendingPathComponent(filename)
            
            let resizedImage = resizedForWidget(originalImage)

            guard let data = resizedImage.jpegData(compressionQuality: 0.8) else { return nil }

            try data.write(to: destinationURL, options: .atomic)

            return destinationURL
        } catch {
            return nil
        }
    }
    
    private func resizedForWidget(_ image: UIImage, maxPixelArea: CGFloat = 300_000) -> UIImage {
        let pixelWidth  = image.size.width * image.scale
        let pixelHeight = image.size.height * image.scale
        let currentArea = pixelWidth * pixelHeight
        
        guard currentArea > maxPixelArea else {
            return image
        }

        let scaleFactor = sqrt(maxPixelArea / currentArea)

        let newPixelWidth  = pixelWidth * scaleFactor
        let newPixelHeight = pixelHeight * scaleFactor

        let targetSize = CGSize(
            width: newPixelWidth / image.scale,
            height: newPixelHeight / image.scale
        )

        let format = UIGraphicsImageRendererFormat()
        format.scale = 1.0
        format.opaque = true

        let renderer = UIGraphicsImageRenderer(
            size: targetSize,
            format: format
        )

        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
