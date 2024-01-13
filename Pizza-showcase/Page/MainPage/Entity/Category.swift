//
//  Category.swift
//  Pizza-showcase
//
//  Created by Ruslan Ismailov on 13/01/24.
//

import Foundation

enum CategoryType: String {
    case pizza = "Пицца"
    case combo = "Комбо"
    case desert = "Десерты"
    case drinks = "Напитки"
}
struct Category {
    let categoryType: CategoryType
    var focusItem: Bool
}
