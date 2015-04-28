//
//  RadiusCell.swift
//  Yelp
//
//  Created by Alex & Chelsea Bryan on 4/27/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol RadiusCellDelegate {
    optional func radiusCell(radiusCell: RadiusCell, didChangeValue value: Bool)
}

class RadiusCell: UITableViewCell {
    
    @IBOutlet weak var onSwitch: UISwitch!
    
    weak var delegate: RadiusCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func switchValueChanged() {
        delegate?.radiusCell?(self, didChangeValue: onSwitch.on)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
