//
//  ViewController.swift
//  eCommerce Application
//
//  Created by user on 18/04/23.
//

import UIKit
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController {
    
    
    @IBOutlet weak var ProductCategoryCollectionView: UICollectionView!
    var urlString = "https://fakestoreapi.com/products/categories"
    var productCategoryListArr : [String] = []
    var productCategoryImageArr : [String] = ["https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg","https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg","https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg","https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg",]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureItems()
        
        APIManager.share.callAPIRequest(urlString: urlString) { responseJSON in
            print("ResponseJson \(responseJSON)")
            //assign data to jsonResponseHandler
            self.jsonResponseHandler(responseJSON)
        } errorCompletion: { error in
            print("Error \(error.localizedDescription)")
        }
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

    
    func setupCollectionView() {
        ProductCategoryCollectionView.delegate = self
        ProductCategoryCollectionView.dataSource = self
        ProductCategoryCollectionView.register(UINib(nibName: "ProductCategoryColectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCategoryColectionViewCell")
    }
    
    func jsonResponseHandler(_ json:JSON) {
        for index in json {
            let value = "\(index.1)"
            self.productCategoryListArr.append(value)
        }
        self.ProductCategoryCollectionView.reloadData()
    }
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productCategoryListArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ProductCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCategoryColectionViewCell", for: indexPath) as! ProductCategoryColectionViewCell
        cell.ProductCategory.text = productCategoryListArr[indexPath.row].uppercased()
        let url = URL(string:productCategoryImageArr[indexPath.row])
        cell.ProductImage.kf.setImage(with: url)
        cell.ProductImage.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        if let  ProductListViewController = storyboard?.instantiateViewController(withIdentifier: "ProductListViewController")
            as? ProductListViewController {
            ProductListViewController.categoryName = productCategoryListArr[indexPath.row]
            self.navigationController?.pushViewController(ProductListViewController, animated: true)
        }
    }
}

