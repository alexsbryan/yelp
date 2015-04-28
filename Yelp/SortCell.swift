//
//  SortCell.swift
//  Yelp
//
//  Created by Alex & Chelsea Bryan on 4/27/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//
import UIKit

@objc protocol SortCellDelegate {
    optional func sortCell(sortCell: SortCell, sortChanged newSortValue: Int)
}

class SortCell: UITableViewCell {
    
    @IBOutlet weak var onSwitch: UISwitch!
    
    @IBOutlet weak var segments: UISegmentedControl!
    
    weak var delegate: SortCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        segments.addTarget(self, action: "sortChanged", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func sortChanged() {
        delegate?.sortCell?(self, sortChanged: segments.selectedSegmentIndex)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
