//
//  ExtensionMainCollection.swift
//  Pizza-showcase
//
//  Created by Ruslan Ismailov on 13/01/24.
//

import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return delegate?.banners.count ?? 2
        }
        if collectionView == categoryCollectionView {
            return delegate?.category.count ?? 0
        }
        if collectionView == pizzasCollectionView {
            return delegate?.pizzas.count ?? 0
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.date = self.delegate?.banners[indexPath.item]
            return cell
        }
        if collectionView == categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            if indexPath == categorySelectedIndexPath {
                delegate?.category[indexPath.row].focusItem = true
            } else {
                delegate?.category[indexPath.row].focusItem = false
            }
            cell.layer.cornerRadius = 15
            UIView.transition(with: collectionView, duration: 0.3, options: .allowAnimatedContent, animations: {
                cell.date = self.delegate?.category[indexPath.item]
            }, completion: nil)
            return cell
        }
        if collectionView == pizzasCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PizzaCellCollectionViewCell", for: indexPath) as? PizzaCellCollectionViewCell else {
                return UICollectionViewCell()
            }
                cell.date = self.delegate?.pizzas[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            if previosCategoryIndex == categorySelectedIndexPath {
                categorySelectedIndexPath = nil
                if let previosCategoryIndex = previosCategoryIndex {
                    collectionView.reloadItems(at: [previosCategoryIndex])
                }
            }
            categorySelectedIndexPath = indexPath
            collectionView.reloadItems(at: [indexPath])
            
            let firstInChoosedCategory = findChoosedCategory(category: delegate?.category[indexPath.row].categoryType.rawValue ?? "")
            let indexPath = IndexPath(item: firstInChoosedCategory, section: 0)
            pizzasCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            previosCategoryIndex = categorySelectedIndexPath
        }
    }
    
    private func findChoosedCategory(category: String) -> Int{
        let firstInCategory = delegate?.pizzas.firstIndex(where: {$0.category == category})
        return firstInCategory ?? 0
    }
}
