//
//  AddCofffeeOrderVC.swift
//  MVVMTutorial
//
//  Created by iOSDev on 6/20/19.
//  Copyright © 2019 Duch Chamroeurn. All rights reserved.
//

import UIKit

protocol AddCoffeeOrderDelegate {
    func addCoffeeOrderViewControllerDidSave(order: OrderCoffee, vc: UIViewController)
}



class AddCofffeeOrderVC: UIViewController {
    
    var delegate: AddCoffeeOrderDelegate?
    
    private var tableView: UITableView!
    private var vm = AddCoffeeOrderVM()
    private var coffeeSizeSegmentedControl: UISegmentedControl!
    private var nameTextField: UITextField!
    private var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    private func setupUI() {
        
        title = "Add Coffee Order"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSaveTapped(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancelVC(_:)))
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.4), style: .grouped)
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AddCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        let y = view.frame.height * 0.4 + 20
        let w = view.frame.width * 0.4
        
        self.coffeeSizeSegmentedControl = UISegmentedControl(items: vm.sizes)
        self.coffeeSizeSegmentedControl.selectedSegmentIndex = 0
        self.coffeeSizeSegmentedControl.frame = CGRect(x: 0, y: y, width: w, height: 30)
        self.coffeeSizeSegmentedControl.clipsToBounds = true
        self.coffeeSizeSegmentedControl.center.x = view.center.x
        view.addSubview(self.coffeeSizeSegmentedControl)
        
        
        nameTextField = UITextField(frame: CGRect(x: 0, y: y + 50, width: view.frame.width * 0.8, height: 40))
        view.addSubview(nameTextField)
        nameTextField.clipsToBounds = true
        nameTextField.center.x = view.center.x
        nameTextField.placeholder = "Enter name"
        nameTextField.borderStyle = .roundedRect
        
        emailTextField = UITextField(frame: CGRect(x: 0, y: y + 110, width: view.frame.width * 0.8, height: 40))
        view.addSubview(emailTextField)
        emailTextField.clipsToBounds = true
        emailTextField.center.x = view.center.x
        emailTextField.placeholder = "Enter email"
        emailTextField.borderStyle = .roundedRect
    }
    
    @objc func handleCancelVC(_ sender: UIBarButtonItem!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSaveTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        
        let selectedSize = self.coffeeSizeSegmentedControl.titleForSegment(at: self.coffeeSizeSegmentedControl.selectedSegmentIndex)
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            
            AppManager.showMesssage(title: "Please select coffee type!")
            
            return
        }
        
        self.vm.name = name
        self.vm.email = email
        self.vm.selectedSize = selectedSize
        self.vm.selectedType = self.vm.types[indexPath.row]
        
        if self.vm.validate() {
            WebService().load(resource: OrderCoffee.create(vm: self.vm)) {[unowned self] result in
                switch result {
                    
                case .success(let orderCoffee):
                    if let order = orderCoffee, let delegate = self.delegate {
                        DispatchQueue.main.async {
                            delegate.addCoffeeOrderViewControllerDidSave(order: order, vc: self)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    AppManager.showMesssage(title: error.localizedDescription)
                }
            }
        } else {
            
            AppManager.showMesssage(title: "Invalid name and email!")
            
        }
        
        
    }


}


extension AddCofffeeOrderVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath)
        cell.selectionStyle = .none
        
        cell.textLabel?.text = self.vm.types[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    
}
