//
//  ViewController.swift
//  Wheel
//
//  Created by Stephanie Liu on 4/2/16.
//  Copyright © 2016 Stephanie Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    let gradientLayer = CAGradientLayer()
    var Array:[String] = []
    var entries = 1
    var weightArray:[Int] = []
    var indexArray:[Int] = []
    var currentRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        
//        // 1
//        self.view.backgroundColor = UIColor.whiteColor()
//        
//        // 2
//        gradientLayer.frame = self.view.bounds
//        
//        // 3
//        let color1 = UIColor(red: 0.337, green: 0.6157, blue: 0.6157, alpha: 1.0).CGColor as CGColorRef
//        let color2 = UIColor(red: 0.710, green: 0.4627, blue: 0.604, alpha: 1.0).CGColor as CGColorRef
//        gradientLayer.colors = [color1, color2]
//        
//        // 4
//        gradientLayer.locations = [0.0, 0.65]
//        
//        // 5
//        self.view.layer.addSublayer(gradientLayer)
//        
        self.tableView.backgroundColor = .clearColor()
        
        
        self.tableView.rowHeight = 84.0
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    /*@IBAction func button1waspressed(sender: AnyObject) {
        print("Button1")
        textFieldTwo.hidden = false
        
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == textFieldOne {
            print("hello world")
            textFieldOne.resignFirstResponder() // Bring keyboard down
        }
    }*/
    @IBAction func buttonAddRow(sender: AnyObject) {
        entries = entries + 1
        // Update Table Data
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([
            NSIndexPath(forRow: entries - 1, inSection: 0)
            ], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }
    
    @IBAction func didEndOnExit(sender: UITextField) {
        if sender.text!.characters.count > 0
        {
            let index = indexArray[currentRow]
            Array.insert(sender.text!, atIndex:index)
        }
        print(Array)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries
    }
    

    func deletePressed(sender: UIButton) {
        print(sender.tag)
        if Array.count > sender.tag {
            Array.removeAtIndex(sender.tag)
        }
        print(Array)
        for index in sender.tag ..< (weightArray.count - 1) {
            if (weightArray[index] != 0) {
                weightArray[index] = weightArray[index + 1]
            }
        }
        for index in sender.tag ..< (weightArray.count) {
            if (indexArray[index] != 0) {
                if (indexArray[index] > indexArray[sender.tag]) {
                    indexArray[index] = indexArray[index] -  1
                }
            }
            print(indexArray)
        }

        weightArray.removeAtIndex(weightArray.count - 1)
        entries = entries - 1
        
        // Update Table Data
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([
            NSIndexPath(forRow: sender.tag, inSection: 0)
            ], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }
    
    func upButtonPressed(sender: UIButton) {
        let index = indexArray[sender.tag]
        weightArray[index] = weightArray[index] + 1
        print(weightArray)
        print(Array)
    }
    
    func downButtonPressed(sender: UIButton) {
        let index = indexArray[sender.tag]
        if (sender.tag != 0) {
            weightArray[index] = weightArray[index] - 1
        }
        print(weightArray)
    }
    
    
    
    // Returning UITableViewCell to the TableView
    // Automatically interates through all the rows
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        weightArray.append(0)
        indexArray.append(0)
        currentRow = indexPath.row
        let cell = tableView.dequeueReusableCellWithIdentifier("choreCell") as! ChoreCell
        cell.deleteCell.tag = indexPath.row
        cell.deleteCell.addTarget(self, action: #selector(ViewController.deletePressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        indexArray[indexPath.row] = indexPath.row
        cell.upButton.tag = indexPath.row
        cell.upButton.addTarget(self, action: #selector(ViewController.upButtonPressed(_:)), forControlEvents: .TouchUpInside)
        cell.downButton.tag = indexPath.row
        cell.downButton.addTarget(self, action: #selector(ViewController.downButtonPressed(_:)), forControlEvents: .TouchUpInside)
        return cell
        
    }
    
}



