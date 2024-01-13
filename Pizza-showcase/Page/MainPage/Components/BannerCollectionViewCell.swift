//
//  BannerCollectionViewCell.swift
//  Pizza-showcase
//
//  Created by Ruslan Ismailov on 13/01/24.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .red.withAlphaComponent(0.5)
        return image
    }()
    var date: Banner? {
        didSet {
            guard let unwrData = date else {return}
            image.image = UIImage(named: unwrData.image)
            image.layer.opacity = unwrData.opacity
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
        image.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
