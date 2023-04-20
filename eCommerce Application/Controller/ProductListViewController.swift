//
//  ProductListViewController.swift
//  eCommerce Application
//
//  Created by user on 19/04/23.
//

import UIKit
import SwiftyJSON
import Kingfisher

class ProductListViewController: UIViewController{
    
    
    
    
    
    @IBOutlet weak var ProductListTableView: UITableView!
    
    var productListArr : [ProductList] = []
    var categoryName : String = ""
    var urlString = "https://fakestoreapi.com/products/category/"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupURLString()
        
        
        APIManager.share.callAPIRequest(urlString: urlString) { responseJSON in
            self.jsonResponseHandler(responseJSON)
            
        } errorCompletion: { error in
            print("Error \(error.localizedDescription)")
        }
        configureItems()
    }
    
    func configureItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(openViewCart))
    }
    
    @objc func openViewCart () {
        if let ViewCartProductsViewController = storyboard?.instantiateViewController(withIdentifier: "ViewCartProductsViewController")
            as? ViewCartProductsViewController {
            self.navigationController?.pushViewController(ViewCartProductsViewController, animated: true)
        }
        
    }
    
    func setupURLString() {
        categoryName = categoryName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        urlString = urlString + categoryName
    }
    
    func setupTableView() {
        ProductListTableView.delegate = self
        ProductListTableView.dataSource = self
        ProductListTableView.register(UINib(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTableViewCell")
    }
    
    func jsonResponseHandler(_ json:JSON) {
        productListArr.removeAll()
        for index in json {
            self.productListArr.append(ProductList(json: index.1))
        }
        self.ProductListTableView.reloadData()
    }
    
}


extension ProductListViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListArr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ProductListTableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell", for: indexPath) as! ProductListTableViewCell
        let modelItem = productListArr[indexPath.row]
        cell.ProductDescription.text = modelItem.description
        cell.ProductDescription.numberOfLines = 4
  
        cell.ProductTitle.text = modelItem.title
        cell.ProductTitle.numberOfLines = 2
        
        if let price = modelItem.price {
            cell.ProductPrice.text = "$ \(String(describing: price))"
        }
        let url = URL(string: modelItem.image!)
        
        cell.delegate = self
        cell.AddCartButton.tag =  indexPath.row
        cell.ProductImage.kf.setImage(with: url)
        cell.ProductImage.clipsToBounds = true
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth  = 1
        cell.layer.borderColor  = UIColor.black.cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let ProductDetailViewController = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController")
            as? ProductDetailViewController {
            ProductDetailViewController.productDetailsList = productListArr[indexPath.row]
            self.navigationController?.pushViewController(ProductDetailViewController, animated: true)
        }
    }
}


extension ProductListViewController : CellDelegate {
    func AddCartTapped(tag: Int) {
        let vc = ViewCartProductsViewController()
        let id = productListArr[tag].id
        let title =  productListArr[tag].title
        let imageView =  productListArr[tag].image
        let price =  productListArr[tag].price
        vc.createItem(productId: id!, name: title!, image: imageView!, price: price!)
    }
    

}
