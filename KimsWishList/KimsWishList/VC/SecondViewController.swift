//
//  SecondViewController.swift
//  KimsWishList
//
//  Created by 민웅킴 on 4/15/24.
//

import UIKit
import CoreData

class SecondViewController: UITableViewController {
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
                // CoreData Products
    var productList: [Products] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        setProductList()
    }
    
    
    func setProductList() {
        guard let context = self.persistentContainer?.viewContext else {return}
                // CoreData Products
        let request = Products.fetchRequest()
        
        if let productList = try? context.fetch(request) {
            self.productList = productList
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let product = self.productList[indexPath.row]
        
        let id = product.id
        let title = product.title ?? ""
        let price = product.price
        
        cell.textLabel?.text = "[\(id)] \(title) - \(price)$"
        return cell
    }
}
