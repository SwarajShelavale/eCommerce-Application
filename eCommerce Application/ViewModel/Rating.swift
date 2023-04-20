
import UIKit
import SwiftyJSON


struct Rating  {
    let rate : Double?
    let count : Int?

    init(json:JSON){
        rate = json["rate"].doubleValue
        count = json["count"].intValue
    }

}
