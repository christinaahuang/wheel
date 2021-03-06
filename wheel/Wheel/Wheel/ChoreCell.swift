//
//  ChoreCell.swift
//  Wheel
//
//  Created by Stephanie Liu on 4/2/16.
//  Copyright © 2016 Stephanie Liu. All rights reserved.
//

import UIKit

class ChoreCell: UITableViewCell {

    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var deleteCell: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        weightLabel.text = String(0)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func didPressDelete(sender: AnyObject) {
        weightLabel.text = String(0)
        textField.text = ""
    }
    @IBAction func didPressUpButton(sender: AnyObject) {
        if let labelValue = Int(weightLabel.text!) {
            weightLabel.text = String(labelValue + 1)
        }
    }
    
    @IBAction func didPressDownButton(sender: AnyObject) {
        if let labelValue = Int(weightLabel.text!) {
            if labelValue != 0
            {
                weightLabel.text = String(labelValue - 1)
            }
        }
    }
    
    
    
}
