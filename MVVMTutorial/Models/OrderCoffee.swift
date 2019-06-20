//
//  OrderCoffee.swift
//  MVVMTutorial
//
//  Created by iOSDev on 6/17/19.
//  Copyright © 2019 Duch Chamroeurn. All rights reserved.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    
    case cappuccino
    case latte
    case espressino
    case cortado
}

enum CoffeeSize: String,Codable, CaseIterable {
    
    case small
    case medium
    case large
}

struct OrderCoffee: Codable {
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}
