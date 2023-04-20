//
//  APIManager.swift
//  eCommerce Application
//
//  Created by user on 18/04/23.
//

import UIKit
import Alamofire
import SwiftyJSON


typealias SuccessBlock = (JSON) -> Void
typealias ErrorBlock = (Error) -> Void
class APIManager {
        
    
    static var share = APIManager()
    // MARK: - Variables
    var successResponse: SuccessBlock!
    var errorResponse:  ErrorBlock!
    var urlString = "https://fakestoreapi.com/products/categories"
    
    // MARK: - Init
    init() {
        
    }
    
//    func urlString() {
//
//    }
    
    
    // MARK: - API Call Request
    func callAPIRequest(urlString: String , succesCompletion: @escaping SuccessBlock, errorCompletion: @escaping ErrorBlock) {
        AF.request(urlString, method: .get).responseJSON { response in
//            print(response)
            
            if let error = response.error {
                errorCompletion(error)
            }
            else {
                if let responseData = response.data {
                    let json = JSON(responseData)
                    succesCompletion(json)
                }
            }
        }
        
    }
}
