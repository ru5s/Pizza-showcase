//
//  MainScrollView.swift
//  Pizza-showcase
//
//  Created by Ruslan Ismailov on 13/01/24.
//

import Foundation
import UIKit

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let center = CGPoint(x: bannerCollectionView.bounds.midX, y: bannerCollectionView.bounds.midY)
        defaultOpacity()
        if let indexPath = bannerCollectionView.indexPathForItem(at: center) {
            let visibleCellIndex = indexPath.item
            delegate?.banners[visibleCellIndex].opacity = 1.0
            bannerCollectionView.reloadItems(at: [IndexPath(row: visibleCellIndex, section: 0)])
        }
        
        let centerForPizza = CGPoint(x: pizzasCollectionView.bounds.midX, y: pizzasCollectionView.bounds.midY)
        if let indexPath = pizzasCollectionView.indexPathForItem(at: centerForPizza) {
            let visibleIndex = indexPath.item
            let index = findChoosedCategoryType(category: delegate?.pizzas[visibleIndex].category ?? "")
            categorySelectedIndexPath?.row = index
            if previosCategoryIndex != categorySelectedIndexPath {
                categorySelectedIndexPath = nil
                if let previosCategoryIndex = previosCategoryIndex {
                    categoryCollectionView.reloadItems(at: [previosCategoryIndex])
                }
            } else {
                
            }
            categorySelectedIndexPath = IndexPath(row: index, section: 0)
            categoryCollectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
            previosCategoryIndex = categorySelectedIndexPath
        }
    }
    
    private func defaultOpacity(){
        let count = (delegate?.banners.count ?? 0) - 1
        for i in 0...count {
            delegate?.banners[i].opacity = 0.5
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var firstOffset: CGFloat = 0
        let newContentOffset = scrollView.contentOffset.y.rounded(.down)
        if newContentOffset > firstOffset {
            UIView.animate(withDuration: 0.2) {
                self.constraintToHideBanner?.constant = 0
                self.view.layoutIfNeeded()
            }
        }
        if newContentOffset < firstOffset {
            UIView.animate(withDuration: 0.2) {
                self.constraintToHideBanner?.constant = 120
                self.view.layoutIfNeeded()
            }
        }
        firstOffset = newContentOffset
    }
    
    private func findChoosedCategoryType(category: String) -> Int{
        let firstInCategory = delegate?.category.firstIndex(where: {$0.categoryType.rawValue == category})
        return firstInCategory ?? 0
    }
}
