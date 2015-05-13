//
//  MapViewController.swift
//  Lesson04
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var capitolText: UITextField!
    @IBOutlet weak var countryText: UITextField!
    var capitolCountryDict = [String:String]()
    let tableViewCell2 = "tableCell2"
    var keyArray:[String] {
        get {
            return Array(capitolCountryDict.keys)
        }
    }
    var valueArray:[String] {
        get {
            return Array(capitolCountryDict.values)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        capitolText.delegate = self
        countryText.delegate = self
        capitolText.clearsOnBeginEditing = true
        countryText.clearsOnBeginEditing = true
        capitolCountryDict["Paris"] = "France"
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter() .addObserver(self, selector: "keyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter() .addObserver(self, selector: "keyboardDidHideNotification:", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        countryText.resignFirstResponder()
        return true;
        }
    
    func capitolTextShouldClear(capitolText: UITextField) -> Bool {
            return true;
        }
    
    func countryTextShouldClear(countryText: UITextField) -> Bool {
            return true;
        }
    
    func keyboardWillShowNotification(notification:NSNotification) {
        capitolText.backgroundColor = UIColor.blueColor()
        countryText.backgroundColor = UIColor.blueColor()
    }
    
    func keyboardDidHideNotification(notification: NSNotification) {
        capitolText.backgroundColor = UIColor.redColor()
        countryText.backgroundColor = UIColor.redColor()
    }
    
    @IBAction func updateDict() {
        let capitol = capitolText.text
        let country = countryText.text
        capitolCountryDict[capitol] = country
        println(capitolCountryDict.description)
        self.tableView.reloadData()
    }
    
    // MARK: Table View

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return capitolCountryDict.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let cell = tableView.dequeueReusableCellWithIdentifier(tableViewCell2, forIndexPath: indexPath) as! UITableViewCell
        
        if let rowKey = keyArray[row] as String? {
            cell.textLabel!.text = rowKey
            let rowData = capitolCountryDict[rowKey]
            cell.detailTextLabel!.text = rowData
        } else {
            cell.textLabel!.text = "Error"
        }
        println(keyArray.count)
        return cell
    }
    
    // MARK: TODO FIVE
    
        /*

        TODO three: Add TWO text views and a table view to this view controller, either using code or storybaord. Accept keyboard input from the two text views. When the 'return' button is pressed on the SECOND text view, add the text view data to a dictionary. The KEY in the dictionary should be the string in the first text view, the VALUE should be the second.
        
        TODO four: Make this class a UITableViewDelegate and UITableViewDataSource that supply this table view with cells that correspond to the values in the dictionary. Each cell should print out a unique pair of key/value that the map contains. When a new key/value is inserted, the table view should display it.
        
        TODO five: Make the background of the text boxes in this controller BLUE when the keyboard comes up, and RED when it goes down. Start with UIKeyboardWillShowNotification and NSNotificationCenter.
        */
    }
