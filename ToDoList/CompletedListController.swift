//
//  CompletedListController.swift
//  ToDoList
//
//  Created by Sang Saephan on 10/20/16.
//  Copyright © 2016 Sang Saephan. All rights reserved.
//

import UIKit

class CompletedListController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var completedList: [Int:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedList.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CompletedCell", forIndexPath: indexPath)
        cell.textLabel?.font = UIFont(name: "Noteworthy", size: 24)
        cell.textLabel?.text = completedList[indexPath.row]
        
        return cell
    }

}
