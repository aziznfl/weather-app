//
//  HomeViewController+CollectionView.swift
//  WeatherApp
//
//  Created by Aziz Nurfalah on 06/01/26.
//

import UIKit

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: CardLayout.longestWidth,
            height: collectionView.bounds.height
        )
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardViewCell.identifier,
            for: indexPath
        ) as! CardViewCell
        
        cell.configure(item: items[indexPath.item])
        return cell
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateCurrentPage()
    }

    func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
        if !decelerate {
            updateCurrentPage()
        }
    }
    
    private func centeredIndexPath() -> IndexPath? {
        let visibleCenterX = collectionView.contentOffset.x + collectionView.bounds.width / 2
        
        let adjustedCenterX = visibleCenterX - collectionView.contentInset.left
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return nil }
        let itemWidth = CardLayout.longestWidth + layout.minimumLineSpacing
        let index = Int(round(adjustedCenterX / itemWidth))
        
        guard index >= 0 && index < collectionView.numberOfItems(inSection: 0) else { return nil }
        return IndexPath(item: index, section: 0)
    }

    private func updateCurrentPage() {
        guard let indexPath = centeredIndexPath() else { return }
        pageControl.currentPage = indexPath.item
    }
}
