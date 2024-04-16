//
//  ViewController.swift
//  KimsWishList
//
//  Created by 민웅킴 on 4/15/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.fetchNextProduct()
//        
//    }
    
    
    //CoreData를 넣기 위해 컨테이너를 가져온다
    var persistentContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchNextProduct()
        
    }
    
    @IBOutlet weak var wishImageView: UIImageView!
    
    @IBOutlet weak var wishTitle: UILabel!
    
    @IBOutlet weak var wishDescription: UILabel!
    
    @IBOutlet weak var wishPrice: UILabel!
    
    
    //struct Product
    private var currentProduct: Product? = nil {
        
        //
        /*
         var myProperty: Int = 20{
            didSet(oldVal){
               //myProperty의 값이 변경된 직후에 호출,
               //oldVal은 변경 전 myProperty의 값
            }
            willSet(newVal){
               //myProperty의 값이 변경되기 직전에 호출,
               //newVal은 변경 될 새로운 값
            }
         }
         */
        didSet {
            guard let currentProduct = self.currentProduct else {return}
            
            DispatchQueue.main.async {
                self.wishImageView.image = nil
                self.wishTitle.text = currentProduct.title
                self.wishDescription.text = currentProduct.description
                self.wishPrice.text = "\(currentProduct.price)$"
            }
            
            //
            /*global(qos:)
            Returns the global system queue with the specified quality-of-service class.
            class func global(qos: DispatchQoS.QoSClass = .default) -> DispatchQueue
             */
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: currentProduct.thumbnail), let image = UIImage(data: data) {
                    DispatchQueue.main.async { self?.wishImageView.image = image}
                }
            }
        }
    }
    
    
//    func fetch
//    let productIDlet = Array(1...100)
    
    func fetchNextProduct() {
        
        let productID = Int.random(in: 1...100)
        
        if let url = URL(string: "https://dummyjson.com/products/\(productID)") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    do {
                        //struct Product
                        let product = try JSONDecoder().decode(Product.self, from: data)
                        self.currentProduct = product
                    } catch {
                        print("Decode Error: \(error)")
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
//    funt save
    func saveWishProduct() {
        guard let context = self.persistentContainer?.viewContext else { return }
        
        guard let currentProduct = self.currentProduct else {return}
        
        //CoreData
        let wishProduct = Products(context: context)
        
        wishProduct.id = Int64(currentProduct.id)
        wishProduct.title = currentProduct.title
        wishProduct.price = currentProduct.price
        
        try? context.save()
    }

    
    
    @IBAction func tappedWishAdd(_ sender: Any) {
        self.saveWishProduct()
    }
    
    @IBAction func tappedWishSkip(_ sender: Any) {
        self.fetchNextProduct()
    }
    
    
    @IBAction func tappedWishList(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {return}
        
        self.present(nextVC, animated: true)
    }
    
    @IBAction func tappedBackList(_ sender: Any) {
        guard let backVC = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController else {return}
        
        self.present(backVC, animated: true)
    }
    

    
}

