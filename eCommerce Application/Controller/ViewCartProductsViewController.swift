//
//  ViewCartProductsViewController.swift
//  eCommerce Application
//
//  Created by user on 19/04/23.
//

import UIKit
import SwiftyJSON
import Kingfisher
import CoreData

class ViewCartProductsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CartCellDelegate{
    func StepperValueChanged(tag: Int, value: Int) {
        self.updateItem(item: self.models[tag],quantity:value)
    }
    


    @IBOutlet weak var TotalPriceLabel: UILabel!
    
    @IBOutlet weak var ViewCartTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var models = [ProductCart]()
    var TotalPrice  = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllItems()
        getTotalPrize()
        ViewCartTableView.register(UINib(nibName: "ProductCartTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductCartTableViewCell")
        title = "Cart"
        ViewCartTableView.delegate = self
        ViewCartTableView.dataSource = self
        
        }
    
    @IBAction func Checkout(_ sender: UIButton) {
        
        for item in models {
            self.deleteItem(item: item)
        }
        
        let alert = UIAlertController(title: "Order Succesful", message: "Thank you!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func getTotalPrize() {
        TotalPrice = 0
        for item in models {
            TotalPrice = TotalPrice + ( Int(item.productPrice) * Int(item.quantity))
        }
        updateTotalPrice(totalprice : TotalPrice)
    }
    
    func updateTotalPrice(totalprice : Int) {
            TotalPriceLabel.text = "TotalPrice : \(totalprice)"
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell =  ViewCartTableView.dequeueReusableCell(withIdentifier: "ProductCartTableViewCell", for: indexPath) as! ProductCartTableViewCell

        cell.delegate = self
        cell.QuantityStepper.tag = indexPath.row
        cell.ProductTitle.text = model.productTitle
        let url = URL(string: model.productImage!)
        cell.ProductImage.kf.setImage(with: url)
        cell.ProductImage.clipsToBounds = true
        cell.QuantityLabel.text = "Q:\(model.quantity)"
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth  = 1
        cell.layer.borderColor  = UIColor.black.cgColor
        cell.ProductPrice.text = "$ \(model.productPrice)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete  = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.deleteItem(item: self.models[indexPath.row])
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete])
        return swipeConfiguration
    }

    
    //MARK: - CORE DATA
    func getAllItems() {
        do {
            models = try context.fetch(ProductCart.fetchRequest())
            DispatchQueue.main.async {
                self.ViewCartTableView.reloadData()
            }
        }
        catch {
           //error
        }
    }
    
    func createItem(productId: Int, name : String,image: String , price: Int) {
    
    
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductCart")
        fetchRequest.predicate = NSPredicate(format: "productId == %d" ,productId)
        do {
            let count = try context.count(for: fetchRequest)
            if count > 0 {
                print("Duplicate Entry")
            }else {
                print("New Entry")
                let newItem = ProductCart(context: context)
                newItem.productId = Int64(productId)
                newItem.productTitle = name
                newItem.productImage = image
                newItem.productPrice = Int64(price)
                newItem.quantity = 1
                try context.save()
            }
        }
        catch {
           //error
        }
    }
    
    func deleteItem(item : ProductCart) {
        context.delete(item)
        do {
            try context.save()
            getTotalPrize()
            getAllItems()
        }
        catch {
           //error
        }
    }
    
    func updateItem(item : ProductCart, quantity:Int) {
        item.quantity = Int64(quantity)
        
        do {
            try context.save()
            getTotalPrize()
    
        }
        catch {
           //error
        }
    }



}
