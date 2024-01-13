//
//  CategoryCollectionViewCell.swift
//  Pizza-showcase
//
//  Created by Ruslan Ismailov on 13/01/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "accentRed")
        return label
    }()
    var focusItem: Bool = {
        let bool = Bool()
        return bool
    }()
    var date: Category? {
        didSet {
            guard let unwrData = date else {return}
            label.text = unwrData.categoryType.rawValue
            focusItem = unwrData.focusItem
            
            if focusItem == true {
                label.textColor = UIColor(named: "accentRed")
                contentView.backgroundColor = UIColor(named: "accentRed")?.withAlphaComponent(0.3)
                contentView.layer.borderWidth = 0
            } else {
                label.textColor = UIColor(named: "accentRed")?.withAlphaComponent(0.3)
                contentView.backgroundColor = .clear
                contentView.layer.borderWidth = 1
                contentView.layer.borderColor = UIColor(named: "accentRed")?.withAlphaComponent(0.3).cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        
        
        contentView.layer.cornerRadius = contentView.bounds.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
