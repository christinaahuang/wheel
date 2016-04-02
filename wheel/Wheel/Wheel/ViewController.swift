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
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //textFieldOne.delegate = self
        //
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
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
        return 6
    }
    
    // Returning UITableViewCell to the TableView
    // Automatically interates through all the rows
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("choreCell") as! ChoreCell
        return cell
    }
}

