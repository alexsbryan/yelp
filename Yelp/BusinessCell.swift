//
//  BusinessCell.swift
//  Yelp
//
//  Created by Alex & Chelsea Bryan on 4/25/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBusiness(business: Business) -> Void {
        self.thumbImageView.setImageWithURL(business.imageURL)
        self.nameLabel.text = business.name!
        self.ratingImageView.setImageWithURL(business.ratingImageURL)
        self.ratingLabel.text = "\(business.reviewCount!) Reviews"
        self.addressLabel.text = business.address!
        self.distanceLabel.text = business.distance!
        self.categoryLabel.text = business.categories!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Assuming 2 labels with dynamic height in my cell: myLabelA and myLabelB
        self.nameLabel.preferredMaxLayoutWidth = self.nameLabel.bounds.width
        self.addressLabel.preferredMaxLayoutWidth = self.addressLabel.bounds.width
        self.distanceLabel.preferredMaxLayoutWidth = self.distanceLabel.bounds.width
    }

}
