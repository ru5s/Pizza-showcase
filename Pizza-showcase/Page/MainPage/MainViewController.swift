//
//  ViewController.swift
//  Pizza-showcase
//
//  Created by Ruslan Ismailov on 13/01/24.
//

import UIKit

class MainViewController: UIViewController {
    var delegate: MainModelProtocol?
    
    let country: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor.black
        label.text = "Москва"
        return label
    }()
    let iconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "chevron.down")
        image.tintColor = .black
        return image
    }()
    
    var constraintToHideBanner: NSLayoutConstraint?
    var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 300, height: 120)
        let inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCollectionViewCell")
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = inset
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        return cv
    }()
    
    var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let space = 8
        layout.minimumLineSpacing = CGFloat(space)
        layout.itemSize = CGSize(width: 88, height: 32)
        let inset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        cv.showsHorizontalScrollIndicator = false
        cv.autoresizingMask = .flexibleWidth
        cv.contentInset = inset
        cv.backgroundColor = .clear
        return cv
    }()
    
    var pizzasCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let countOfCell = 1
        let space = 5
        layout.minimumLineSpacing = CGFloat(space)
        let sizeToCell = ((Int(UIScreen.main.bounds.width - 40) - ((countOfCell - 1) * space)) / countOfCell)
        layout.itemSize = CGSize(width: sizeToCell, height: 156)
        let inset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PizzaCellCollectionViewCell.self, forCellWithReuseIdentifier: "PizzaCellCollectionViewCell")
        cv.showsVerticalScrollIndicator = false
        cv.autoresizingMask = .flexibleHeight
        cv.contentInset = inset
        cv.backgroundColor = .white
        return cv
    }()
    var categorySelectedIndexPath: IndexPath?
    var pizzasSelectedCategoryIndexPath: IndexPath?
    var previosCategoryIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        delegate = MainModel()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        addSubviews()
        bannerCollectionView.reloadData()
        categoryCollectionView.reloadData()
        pizzasCollectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        let safeArea = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            country.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            country.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            iconImage.leadingAnchor.constraint(equalTo: country.trailingAnchor, constant: 5),
            iconImage.centerYAnchor.constraint(equalTo: country.centerYAnchor),
            bannerCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bannerCollectionView.widthAnchor.constraint(equalToConstant: 301),
            bannerCollectionView.topAnchor.constraint(equalTo: country.bottomAnchor, constant: 10),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollectionView.topAnchor.constraint(equalTo: bannerCollectionView.bottomAnchor, constant: 10),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 50),
            pizzasCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pizzasCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pizzasCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 10),
            pizzasCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func addSubviews() {
        view.addSubview(country)
        country.addSubview(iconImage)
        view.addSubview(bannerCollectionView)
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.clipsToBounds = false
        firstCellBanner()
        constraintToHideBanner =  bannerCollectionView.heightAnchor.constraint(equalToConstant: 120)
        constraintToHideBanner?.isActive = true
        view.addSubview(categoryCollectionView)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categorySelectedIndexPath = IndexPath(item: 0, section: 0)
        previosCategoryIndex = IndexPath(row: 0, section: 0)
        view.addSubview(pizzasCollectionView)
        pizzasCollectionView.delegate = self
        pizzasCollectionView.dataSource = self
        pizzasCollectionView.layer.cornerRadius = 20
        pizzasSelectedCategoryIndexPath = IndexPath(item: 0, section: 0)
    }
    
    func firstCellBanner(){
        if !(delegate?.banners.isEmpty ?? true) {
            delegate?.banners[0].opacity = 1.0
        }
    }
    
}
