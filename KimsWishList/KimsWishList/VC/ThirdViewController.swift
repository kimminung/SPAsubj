//
//  ThirdViewController.swift
//  KimsWishList
//
//  Created by 민웅킴 on 4/16/24.
//

import UIKit
import CoreData

class ThirdViewController: UIViewController {
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }

    var productList: [Products] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}


extension ThirdViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "ThirdViewCell", for: indexPath)
        
//        let product = self.productList[indexPath.row]
//        
//        let id = product.id
//        let title = product.title ?? ""
//        let price = product.price
//        
//        cell2.textLabel?.text = "[\(id)] \(title) - \(price)$"
        return cell2
    }
}
