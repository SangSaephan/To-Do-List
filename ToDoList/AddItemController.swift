//
//  AddItemController.swift
//  ToDoList
//
//  Created by Sang Saephan on 10/20/16.
//  Copyright © 2016 Sang Saephan. All rights reserved.
//

import UIKit

protocol AddItemControllerDelegate: class {
    func addItemToList(text:String)
}

class AddItemController: UIViewController {
    
    weak var delegate: AddItemControllerDelegate?
    
    @IBOutlet weak var addItemTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        delegate?.addItemToList(addItemTextField.text!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
