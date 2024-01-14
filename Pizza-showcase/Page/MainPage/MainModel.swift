//
//  MainModel.swift
//  Pizza-showcase
//
//  Created by Ruslan Ismailov on 13/01/24.
//

import Foundation
import UIKit

protocol MainModelProtocol {
    var banners: [Banner] { get set }
    var category: [Category] { get set }
    var pizzas: [Pizza] { get set }
    func getPizzasFromApi(competion: @escaping ([Pizza]) -> Void)
    func getBanners (competion: @escaping ([Banner]) -> Void)
}

protocol MainModelImageProtocol {
    func getImageFromStorageFirebase(stringImage: String, comletion: @escaping (UIImage?) -> Void)
}

class MainModel: MainModelProtocol {
    var banners: [Banner] = []
    var category: [Category] = [
        Category(categoryType: .pizza, focusItem: false),
        Category(categoryType: .combo, focusItem: false),
        Category(categoryType: .drinks, focusItem: false),
        Category(categoryType: .desert, focusItem: false),
    ]
    var pizzas: [Pizza] = []
    let group = DispatchGroup()
    
    func getPizzasFromApi(competion: @escaping ([Pizza]) -> Void) {
        FirebaseManager.shared.getItems(collection: "Pizza app", docName: "all_Items") {[weak self] text in
            DispatchQueue.global().async {
                for (index, name) in (text ?? []).enumerated() {
                    self?.group.enter()
                    self?.getItem(name: name, index: index)
                }
                self?.group.wait()
                let sortedPizzas = self?.pizzas.sorted { $0.index < $1.index } ?? []
                DispatchQueue.main.async {
                    competion(sortedPizzas)
                }
            }
        }
    }
    private func getItem(name: String, index: Int) {
        FirebaseManager.shared.getItem(collection: "Pizza app", docName: name) {[weak self] pizza in
            if var pizza = pizza {
                pizza.index = index
                self?.pizzas.append(pizza)
            }
            self?.group.leave()
        }
    }
    func getBanners (competion: @escaping ([Banner]) -> Void) {
        FirebaseManager.shared.getBanners(collection: "Pizza app", docName: "all_baners") {[weak self] banersData in
            DispatchQueue.global().async {
                for (index, image) in (banersData ?? []).enumerated() {
                    let banner: Banner = Banner(id: index, image: image)
                    self?.banners.append(banner)
                }
                DispatchQueue.main.async {
                    let sorted = self?.banners.sorted(by: {$0.id < $1.id}) ?? []
                    competion(sorted)
                }
            }
        }
    }
}
