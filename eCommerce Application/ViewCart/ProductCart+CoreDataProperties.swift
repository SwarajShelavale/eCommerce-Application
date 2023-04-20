//
//  ProductCart+CoreDataProperties.swift
//  eCommerce Application
//
//  Created by user on 20/04/23.
//
//

import Foundation
import CoreData


extension ProductCart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductCart> {
        return NSFetchRequest<ProductCart>(entityName: "ProductCart")
    }

    @NSManaged public var productId: Int64
    @NSManaged public var productImage: String?
    @NSManaged public var productPrice: Int64
    @NSManaged public var productTitle: String?
    @NSManaged public var quantity: Int64

}

extension ProductCart : Identifiable {

}
