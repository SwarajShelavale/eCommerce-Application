//
//  ProductCartTableViewCell.swift
//  eCommerce Application
//
//  Created by user on 20/04/23.
//

import UIKit

protocol CartCellDelegate: class{
    func StepperValueChanged(tag:Int,value:Int)
}
class ProductCartTableViewCell: UITableViewCell {

    @IBOutlet weak var QuantityStepper: UIStepper!
    @IBOutlet weak var QuantityLabel: UILabel!
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var BackgrounfView: UIView!
        
    @IBOutlet weak var ProductPrice: UILabel!
    weak var delegate : CartCellDelegate?
    @IBOutlet weak var ProductTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func QuantityStepperValueChanged(_ sender: UIStepper) {
        QuantityLabel.text = "Q:\(Int(sender.value))"
        delegate?.StepperValueChanged(tag: sender.tag,value:Int(sender.value))
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
