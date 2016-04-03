//
//  ViewController.swift
//  Wheel
//
//  Created by Stephanie Liu on 4/2/16.
//  Copyright © 2016 Stephanie Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    //@IBOutlet weak var scrollView: UIScrollView!
    //@IBOutlet weak var textFieldOne: UITextField!
    //@IBOutlet weak var textFieldTwo: UITextField!
    //@IBOutlet weak var button1: UIButton!
    var Array:[String] = []
    var weight = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        self.tableView.backgroundColor = .clearColor()
        
        //textFieldOne.delegate = self
        //
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    @IBAction func didEndOnExit(sender: UITextField) {
        Array.append(sender.text!)
        print(Array[0])
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
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == textFieldOne {
            print("hello world")
            textFieldOne.resignFirstResponder() // Bring keyboard down
        }
        return true
    }*/
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    // Returning UITableViewCell to the TableView
    // Automatically interates through all the rows
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("choreCell") as! ChoreCell
        return cell
    }
}

