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
}

class MainModel: MainModelProtocol {
    var banners: [Banner] = [
        .init(image: "BanerTest"),
        .init(image: "Rectangle 38"),
        .init(image: "BanerTest"),
        .init(image: "Rectangle 38"),
    ]
    var category: [Category] = [
        Category(categoryType: .pizza, focusItem: true),
        Category(categoryType: .combo, focusItem: false),
        Category(categoryType: .desert, focusItem: false),
        Category(categoryType: .drinks, focusItem: false),
    ]
    var pizzas: [Pizza] = [
        .init(nameOfPizza: "Pepperony", image: "pizzaTest", description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус", price: "от 345 р", category: CategoryType.pizza.rawValue),
        .init(nameOfPizza: "Pepperony", image: "pizzaTest", description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус", price: "от 345 р", category: CategoryType.pizza.rawValue),
        .init(nameOfPizza: "Pepperony", image: "pizzaTest", description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус", price: "от 345 р", category: CategoryType.pizza.rawValue),
        .init(nameOfPizza: "Pepperony", image: "pizzaTest", description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус", price: "от 345 р", category: CategoryType.combo.rawValue),
        .init(nameOfPizza: "Pepperony", image: "pizzaTest", description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус", price: "от 345 р", category: CategoryType.combo.rawValue),
        .init(nameOfPizza: "Pepperony", image: "pizzaTest", description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус", price: "от 345 р", category: CategoryType.combo.rawValue),
        .init(nameOfPizza: "Pepperony", image: "pizzaTest", description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус", price: "от 345 р", category: CategoryType.desert.rawValue),
        .init(nameOfPizza: "Pepperony", image: "pizzaTest", description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус", price: "от 345 р", category: CategoryType.desert.rawValue),
        .init(nameOfPizza: "Pepperony", image: "pizzaTest", description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус", price: "от 345 р", category: CategoryType.drinks.rawValue),
        .init(nameOfPizza: "Pepperony", image: "pizzaTest", description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус", price: "от 345 р", category: CategoryType.drinks.rawValue),
        .init(nameOfPizza: "Pepperony", image: "pizzaTest", description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус", price: "от 345 р", category: CategoryType.drinks.rawValue),
    ]
    func getPizzasFromApi() {
        
    }
    func getPicturesByName(_: String) -> UIImage {
        return UIImage()
    }
}
