//
//  ViewController.swift
//  ToDoList
//
//  Created by Sang Saephan on 10/17/16.
//  Copyright © 2016 Sang Saephan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddItemControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var toDoList: NSMutableArray = ["Study for exam", "Finish project", "Clean the car", "Buy new phone", "Do laundry"]
    
    var completedList: [Int:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        removeToDoItems() // Removes the selected items before reloading the tableView
        resetAccessoryTypes()
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoCell", forIndexPath: indexPath)
        cell.textLabel?.font = UIFont(name: "Noteworthy", size: 24)
        cell.textLabel?.text = toDoList[indexPath.row] as! String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .None {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        }
    }
    
    /*
    Iterates through the toDoList, if the item's cell has a checkmark,
    add it to completedList
    */
    func addCompletedItems() {
        for row in 0..<toDoList.count {
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
                if cell.accessoryType == .Checkmark {
                    completedList[completedList.count] = toDoList[row] as! String
                }
            }
        }
    }
    
    /*
    Iterates through the toDoList in reverse order to remove the last elements first so 
    indexes won't be out of bounds when it decrements. Also, sets the removed cell's accessory
    type to .None
    */
    func removeToDoItems() {
        for row in (0...toDoList.count).reverse() {
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
                if cell.accessoryType == .Checkmark {
                    toDoList.removeObjectAtIndex(row)
                    cell.accessoryType = .None
                }
            }
        }
    }
    
    func resetAccessoryTypes() {
        for row in 0..<toDoList.count {
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
                cell.accessoryType = .None
            }
        }
    }
    
    func addItemToList(text:String) {
        toDoList.insertObject(text, atIndex: toDoList.count)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        addCompletedItems() // Adds selected items to completedList before the user navigates away
        
        if(segue.identifier == "AddItemSegue") {
            let navigationController = segue.destinationViewController as! UINavigationController
            let addItemController = navigationController.topViewController as! AddItemController
            
            addItemController.delegate = self
        } else if (segue.identifier == "CompletedItemSegue") {
            let completedItemController = segue.destinationViewController as! CompletedListController
            completedItemController.completedList = completedList
        }
    }

}

