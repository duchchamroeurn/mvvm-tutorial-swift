//
//  OrderCoffeeViewModel.swift
//  MVVMTutorial
//
//  Created by iOSDev on 6/17/19.
//  Copyright © 2019 Duch Chamroeurn. All rights reserved.
//

import Foundation



class OrderCoffeeListViewModel {
    var orderCoffeesViewModel: [OrderCoffeeViewModel]
    
    init() {
        self.orderCoffeesViewModel = [OrderCoffeeViewModel]()
    }
}

extension OrderCoffeeListViewModel {
    
    func orderCoffeeViewModel(at index: Int) -> OrderCoffeeViewModel {
        return self.orderCoffeesViewModel[index]
    }
}


struct OrderCoffeeViewModel {
    let orderCoffee: OrderCoffee
}

extension OrderCoffeeViewModel {
    
    var name: String {
        return self.orderCoffee.name
    }
    
    var email: String {
        return self.orderCoffee.email
    }
    
    var type: String {
        return self.orderCoffee.type.rawValue.capitalized
    }
    
    var size: String {
        return self.orderCoffee.size.rawValue.uppercased()
    }
}
