//
//  OrderCoffee+Extension.swift
//  MVVMTutorial
//
//  Created by iOSDev on 6/17/19.
//  Copyright © 2019 Duch Chamroeurn. All rights reserved.
//

import Foundation

extension OrderCoffee {
    
    static func create(vm: AddCoffeeOrderVM) -> Resource<OrderCoffee?> {
        
        let order = OrderCoffee(vm)
        
        guard let url = URL(string: "http://127.0.0.1:8000/api/v1/tutorial/order-coffee") else {
            fatalError("URL is not defined!")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order!")
        }
        
        var resource = Resource<OrderCoffee?>(url: url)
        resource.httpMehtod = HttpMethod.POST
        resource.body = data
        
        return resource
    }
    
    static var all: Resource<[OrderCoffee]> = {
        guard let url = URL(string: "http://127.0.0.1:8000/api/v1/tutorial/order-coffee") else {
            fatalError("URL is not defined!")
        }
        
        return Resource<[OrderCoffee]>(url: url)
    }()
}

extension OrderCoffee {
    
    init?(_ vm: AddCoffeeOrderVM) {
        
        guard let name = vm.name,
            let email = vm.email,
            let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
            let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) else {
                return nil
        }
        
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
    }
}
