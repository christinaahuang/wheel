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
    var Array:[String] = []
    var entries = 1
    var weightArray:[Int] = []
    var indexArray:[Int] = []
    let colorArray = [UIColor(red: 180/250.0, green: 4/250.0, blue: 78/250.0, alpha: 1),
                      UIColor(red: 96/250.0, green: 174/250.0, blue: 174/250.0, alpha: 1),
                      UIColor(red: 211/250.0, green: 240/250.0, blue: 232/250.0, alpha: 1),
                      UIColor(red: 109/250.0, green: 4/250.0, blue: 48/250.0, alpha: 1),
                      UIColor(red: 54/250.0, green: 116/250.0, blue: 116/250.0, alpha: 1),
                      UIColor(red: 163/250.0, green: 218/250.0, blue: 202/250.0, alpha: 1),
                      UIColor(red: 231/250.0, green: 5/250.0, blue: 100/250.0, alpha: 1),
                      UIColor(red: 22/250.0, green: 68/250.0, blue: 68/250.0, alpha: 1),
                      UIColor(red: 53/250.0, green: 4/250.0, blue: 24/250.0, alpha: 1)]
    

    var currentRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
 
        self.tableView.backgroundColor = .clearColor()
        self.tableView.rowHeight = 84.0
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func spinPressed(sender: AnyObject) {
        let piechart = Piechart()
        var views: [String: UIView] = [:]
        
        piechart.delegate = self
        piechart.layer.borderWidth = 1
        var slices:[Piechart.Slice] = []
        for i in 0 ..< weightArray.count
        {
            var temp = Piechart.Slice()
            temp.value = CGFloat(weightArray[i])
            temp.color = colorArray[i]
            temp.text = Array[i]
            slices.append(temp)
        }
        piechart.slices = slices
        piechart.activeSlice = slices.count
        piechart.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(piechart, atIndex: 0)
        self.view.layer.borderColor = UIColor.clearColor().CGColor
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[piechart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-42-[piechart(==400)]", options: [], metrics: nil, views: views))
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
        for index in indexArray[sender.tag] ..< (weightArray.count - 1) {
            if (weightArray[index] != 0) {
                weightArray[index] = weightArray[index + 1]
            }
        }
        
        for index in sender.tag ..< (indexArray.count) {
            if (indexArray[index] != 0) {
                if (indexArray[index] > indexArray[sender.tag]) {
                    indexArray[index] = indexArray[index] - 1
                }
            }
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
        if (weightArray[index] != 0) {
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



