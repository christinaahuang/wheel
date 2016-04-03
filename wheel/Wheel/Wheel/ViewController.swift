//
//  ViewController.swift
//  Wheel
//
//  Created by Stephanie Liu on 4/2/16.
//  Copyright © 2016 Stephanie Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, PiechartDelegate {
    let gradientLayer = CAGradientLayer()
    var Array:[String] = ["name"]
    var entries = 1
    var weightArray:[Int] = [1]
    var indexArray:[Int] = []
    var currentRow = 0
    let piechart = Piechart()
    var views: [String: UIView] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        
        piechart.delegate = self
        piechart.activeSlice = 2
        piechart.layer.borderWidth = 1
 
        self.tableView.backgroundColor = .clearColor()
        
        
        self.tableView.rowHeight = 84.0
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func spinPressed(sender: AnyObject) {
        var slices:[Piechart.Slice] = []
        for i in 0 ..< weightArray.count - 1
        {
            var temp = Piechart.Slice()
            temp.value = CGFloat(weightArray[i])
            temp.color = UIColor.redColor()
            temp.text = Array[i]
            slices.append(temp)
        }
        piechart.slices = slices
        
        piechart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(piechart)
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[piechart(==200)]", options: [], metrics: nil, views: views))
        
    }
    
    func setSubtitle(total: CGFloat, slice: Piechart.Slice) -> String {
        return "\(Int(slice.value / total * 100))% \(slice.text)"
    }
    
    func setInfo(total: CGFloat, slice: Piechart.Slice) -> String {
        return "\(Int(slice.value))/\(Int(total))"
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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



