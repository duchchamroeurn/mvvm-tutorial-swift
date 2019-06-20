//
//  AddCoffeeOrderVM.swift
//  MVVMTutorial
//
//  Created by iOSDev on 6/20/19.
//  Copyright © 2019 Duch Chamroeurn. All rights reserved.
//

import Foundation

struct AddCoffeeOrderVM: Validatable {
    
    var name: String?
    var email: String?
    
    
    var selectedType: String?
    var selectedSize: String?
    
    var types: [String] {
        return CoffeeType.allCases.map{ $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map{ $0.rawValue.capitalized }
    }
    
    func validate() -> Bool {
        
        guard let name = self.name,
              let email = self.email,
              let seletedType = self.selectedType,
              let seletedSize = self.selectedSize else {
            return false
        }
        
        
        return !(name.trimmingCharacters(in: .whitespaces).isEmpty || email.trimmingCharacters(in: .whitespaces).isEmpty || seletedSize.isEmpty || seletedType.isEmpty)
    }
    
    
}
