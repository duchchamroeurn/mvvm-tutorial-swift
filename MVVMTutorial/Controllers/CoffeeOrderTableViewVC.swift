//
//  CoffeeOrderTableViewVC.swift
//  MVVMTutorial
//
//  Created by iOSDev on 6/20/19.
//  Copyright © 2019 Duch Chamroeurn. All rights reserved.
//

import UIKit


class CoffeeCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CoffeeOrderTableViewVC: UITableViewController {
    
    var orderListVM = OrderCoffeeListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Lists Coffee Order"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewOrder(_:)))
        tableView.register(CoffeeCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
    }
    
    @objc func addNewOrder(_ sender: UIBarButtonItem!) {
        
        let addCoffeeOrderVC = AddCofffeeOrderVC()
        addCoffeeOrderVC.delegate = self
        let nav = UINavigationController(rootViewController: addCoffeeOrderVC)
        self.present(nav, animated: true, completion: nil)
    }
    
    private func loadData() {
        
        WebService().load(resource: OrderCoffee.all) {[weak self] result in
            
            switch result {
                
            case .success(let orderCoffees):
                self?.orderListVM.orderCoffeesViewModel = orderCoffees.map(OrderCoffeeViewModel.init)
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.orderListVM.orderCoffeesViewModel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vm = self.orderListVM.orderCoffeeViewModel(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CoffeeOrderTableViewVC: AddCoffeeOrderDelegate {
    func addCoffeeOrderViewControllerDidSave(order: OrderCoffee, vc: UIViewController) {
        vc.dismiss(animated: true, completion: nil)
        let orderVM = OrderCoffeeViewModel(orderCoffee: order)
        self.orderListVM.orderCoffeesViewModel.append(orderVM)
        let arrIndexPath = [IndexPath.init(row: self.orderListVM.orderCoffeesViewModel.count - 1, section: 0)]
        self.tableView.insertRows(at: arrIndexPath, with: .automatic)
    }
    
    
}
