//
//  ProductDetailViewController.swift
//  eCommerce Application
//
//  Created by user on 19/04/23.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {

    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProudctTitle: UILabel!
    @IBOutlet weak var ProductDescription: UILabel!
    
    @IBOutlet weak var ProductCatgory: UILabel!
    @IBOutlet weak var ProductPrice: UILabel!
    
    var productDetailsList : ProductList!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: productDetailsList.image!)
        
        ProductImage.kf.setImage(with: url)
        ProductImage.clipsToBounds = true
        ProudctTitle.text = productDetailsList.title
        ProudctTitle.lineBreakMode = .byWordWrapping
        ProudctTitle.numberOfLines = 3
        ProductDescription.text = productDetailsList.description
        ProductDescription.numberOfLines = 6
        if let category = productDetailsList.category {
            ProductCatgory.text = "Category : \(category.uppercased())"
        }
        if let price = productDetailsList.price {
            ProductPrice.text = "Price : $ \(price)"
        }
        configureItems()
    }
    
    @IBAction func AddCart(_ sender: Any) {
        let vc = ViewCartProductsViewController()
        let id = productDetailsList.id
        let title =  productDetailsList.title
        let imageView =  productDetailsList.image
        let price =  productDetailsList.price
        vc.createItem(productId: id!, name: title!, image: imageView!, price: price!)
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
}
