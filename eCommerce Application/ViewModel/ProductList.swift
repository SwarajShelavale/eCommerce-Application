

import UIKit
import SwiftyJSON

struct  ProductList {
    var id : Int?
    var title : String?
    var price : Int?
    var description : String?
    var category : String?
    var image : String?
    var rating : Rating?
    init(json:JSON)
    {
        id = json["id"].intValue
        title = json["title"].stringValue
        price = json["price"].intValue
        description = json["description"].stringValue
        category   = json["category"].stringValue
        image = json["image"].stringValue
    }


}

