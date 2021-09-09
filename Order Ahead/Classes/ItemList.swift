//
//  ItemList.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 8/29/21.
//

import Foundation

struct ItemList: Identifiable, Codable, Hashable {
    var id: Int
    var name: String
    var picture: String
    var list: [Item]
}


let typeList: [ItemList] = [
    milkList, teaList, coffeeList, fruitList, smoothieList
]

let milkList = ItemList(id: 1, name: "Milk Tea", picture: "c-milk-tea", list: milkArr)
let teaList = ItemList(id: 2, name: "Tea", picture: "taro-milk-tea", list: teaArr)
let coffeeList = ItemList(id: 3, name: "Coffee", picture: "taro-milk-tea", list: coffeeArr)
let fruitList = ItemList(id: 4, name: "Fruit Tea", picture: "c-milk-tea", list: fruitArr)
let smoothieList = ItemList(id: 5, name: "Smoothies", picture: "c-milk-tea", list: fruitArr)



let milkArr: [Item] = [
    .init(id: 1, name: "Classic Milk Tea", ingredients: "$5.99", itemArtString: "c-milk-tea", price:699),
    .init(id: 2, name: "Taro Milk Tea", ingredients: "$6.99", itemArtString: "taro-milk-tea", price:499)
]

let teaArr: [Item] = [
    .init(id: 1, name: "Black Tea", ingredients: "$4.99", itemArtString: "c-milk-tea", price:699),
    .init(id: 2, name: "Green Tea", ingredients: "$4.99", itemArtString: "taro-milk-tea", price:499)
]

let coffeeArr: [Item] = [
    .init(id: 1, name: "Classic Milk Tea", ingredients: "$5.99", itemArtString: "c-milk-tea", price:699),
    .init(id: 2, name: "Taro Milk Tea", ingredients: "$6.99", itemArtString: "taro-milk-tea", price:499)
]

let fruitArr: [Item] = [
    .init(id: 1, name: "Black Tea", ingredients: "$4.99", itemArtString: "c-milk-tea", price:699),
    .init(id: 2, name: "Green Tea", ingredients: "$4.99", itemArtString: "taro-milk-tea", price:499)
]
