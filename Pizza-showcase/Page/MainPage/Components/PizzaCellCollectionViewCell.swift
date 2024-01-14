//
//  PizzaCellCollectionViewCell.swift
//  Pizza-showcase
//
//  Created by Ruslan Ismailov on 13/01/24.
//

import UIKit

class PizzaCellCollectionViewCell: UICollectionViewCell {
    var delegate: MainModelImageProtocol?
    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    let namePizza: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.black
        return label
    }()
    let descriptionPizza: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.gray
        label.numberOfLines = 3
        return label
    }()
    let price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "accentRed")
        return label
    }()
    let rectForPrice: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor(named: "accentRed")?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        return view
    }()
    let lineBelow: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "BackgroundColor")
        return view
    }()
    var imageCache = NSCache <NSString, UIImage>()
    var fireStore: FirestoreImageDataSend?
        var date: Pizza? {
            didSet {
                fireStore = FirebaseManager() 
                guard let unwrData = date else {return}
                DispatchQueue.main.async {
                    if let cachedImage = self.imageCache.object(forKey: unwrData.image as NSString) {
                        self.image.image = cachedImage
                    } else {
                        self.fireStore?.getImage(picName: unwrData.image, imageType: .pizzas ) { [self] image in
                            self.image.image = image
                            imageCache.setObject(image, forKey: unwrData.image as NSString)
                        }
                    }
                }
                namePizza.text = unwrData.nameOfPizza
                descriptionPizza.text = unwrData.description
                price.text = unwrData.price
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.addSubview(image)
            contentView.addSubview(namePizza)
            contentView.addSubview(descriptionPizza)
            contentView.addSubview(rectForPrice)
            rectForPrice.addSubview(price)
            contentView.addSubview(lineBelow)
            
            NSLayoutConstraint.activate([
                image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                image.topAnchor.constraint(equalTo: contentView.topAnchor),
                image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                image.widthAnchor.constraint(equalToConstant: 130),
                namePizza.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                namePizza.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
                namePizza.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                descriptionPizza.topAnchor.constraint(equalTo: namePizza.bottomAnchor, constant: 8),
                descriptionPizza.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
                descriptionPizza.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                rectForPrice.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
                rectForPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                rectForPrice.widthAnchor.constraint(equalToConstant: 87),
                rectForPrice.heightAnchor.constraint(equalToConstant: 32),
                price.centerXAnchor.constraint(equalTo: rectForPrice.centerXAnchor),
                price.centerYAnchor.constraint(equalTo: rectForPrice.centerYAnchor),
                lineBelow.heightAnchor.constraint(equalToConstant: 1),
                lineBelow.widthAnchor.constraint(equalToConstant: contentView.frame.width),
                lineBelow.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
