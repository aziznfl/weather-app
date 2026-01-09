//
//  CenterSnapViewFlowLayout.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 07/01/26.
//

import UIKit

final class CenterSnapFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        guard let collectionView = collectionView else {
            return proposedContentOffset
        }

        let targetRect = CGRect(
            x: proposedContentOffset.x,
            y: 0,
            width: collectionView.bounds.width,
            height: collectionView.bounds.height
        )

        guard let attributes = layoutAttributesForElements(in: targetRect) else {
            return proposedContentOffset
        }

        var closest = CGFloat.greatestFiniteMagnitude
        let centerX = proposedContentOffset.x + collectionView.bounds.width / 2

        for attr in attributes {
            let distance = attr.center.x - centerX
            if abs(distance) < abs(closest) {
                closest = distance
            }
        }

        return CGPoint(x: proposedContentOffset.x + closest,
                       y: proposedContentOffset.y)
    }
}
