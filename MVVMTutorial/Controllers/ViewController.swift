//
//  ViewController.swift
//  MVVMTutorial
//
//  Created by iOSDev on 6/17/19.
//  Copyright © 2019 Duch Chamroeurn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }
    
    private func loadData() {
        
        WebService().load(resource: OrderCoffee.all) { result in
        
            switch result {
        
            case .success(let orderCoffees):
                print("Items = ", orderCoffees)
            case .failure(let error):
                print(error)
            }
        }
    }


}

