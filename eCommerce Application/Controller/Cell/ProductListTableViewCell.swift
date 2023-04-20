//
//  ProductListTableViewCell.swift
//  eCommerce Application
//
//  Created by user on 19/04/23.
//

import UIKit

protocol CellDelegate: class{
    func AddCartTapped(tag:Int)
}
class ProductListTableViewCell: UITableViewCell {
    //AddCartButtonTapped

    @IBOutlet weak var ProductImage: UIImageView!
    
    @IBOutlet weak var ProductDescription: UILabel!
    
    @IBOutlet weak var AddCartButton: UIButton!
    
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var ProductTitle: UILabel!
    
    @IBOutlet weak var ProductListBackgroundView: UIView!
    
    weak var delegate : CellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func AddItemToCart(_ sender: UIButton) {
        delegate?.AddCartTapped(tag: sender.tag)
    }
 
}
