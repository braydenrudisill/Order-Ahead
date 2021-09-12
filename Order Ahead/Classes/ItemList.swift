//
//  ItemList.swift
//  Order Ahead
//
//  Created by Brayden Rudisill on 8/29/21.
//

import Foundation
import SwiftUI

struct ItemList: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var picture: String
    var list: [ItemModel]
}


let typeList: [ItemList] = [
    milkList, teaList, coffeeList, fruitList, smoothieList
]

let milkList = ItemList(name: "Milk Tea", picture: "c-milk-tea", list: milkArr)
let teaList = ItemList(name: "Tea", picture: "taro-milk-tea", list: teaArr)
let coffeeList = ItemList(name: "Coffee", picture: "taro-milk-tea", list: coffeeArr)
let fruitList = ItemList(name: "Fruit Tea", picture: "c-milk-tea", list: fruitArr)
let smoothieList = ItemList(name: "Smoothies", picture: "c-milk-tea", list: fruitArr)



let milkArr: [ItemModel] = [
    ItemModel(name: "Classic Milk Tea", ingredients: "$5.99", itemArtString: "c-milk-tea", price:699),
    ItemModel(name: "Taro Milk Tea", ingredients: "$6.99", itemArtString: "taro-milk-tea", price:499)
]

let teaArr: [ItemModel] = [
    ItemModel(name: "Black Tea", ingredients: "$4.99", itemArtString: "c-milk-tea", price:699),
    ItemModel(name: "Green Tea", ingredients: "$4.99", itemArtString: "taro-milk-tea", price:499)
]

let coffeeArr: [ItemModel] = [
    ItemModel(name: "Classic Milk Tea", ingredients: "$5.99", itemArtString: "c-milk-tea", price:699),
    ItemModel(name: "Taro Milk Tea", ingredients: "$6.99", itemArtString: "taro-milk-tea", price:499)
]

let fruitArr: [ItemModel] = [
    ItemModel(name: "Black Tea", ingredients: "$4.99", itemArtString: "c-milk-tea", price:699),
    ItemModel(name: "Green Tea", ingredients: "$4.99", itemArtString: "taro-milk-tea", price:499)
]
