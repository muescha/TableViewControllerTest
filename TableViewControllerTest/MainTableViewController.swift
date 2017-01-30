//
//  ViewController.swift
//  TableViewControllerTest
//
//  Created by Zion Perez on 1/29/17.
//  Copyright © 2017 Zion Perez. All rights reserved.
//

import UIKit

class InputTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var didSelectCallback: ((_ text: String) -> Void)!
    
    func setupTableView(didSelectCallback: @escaping (_ text: String)-> Void){
        self.dataSource = self
        self.delegate = self
        self.didSelectCallback = didSelectCallback
    }
    
    // MARK: - TableView DataSource
    // https://developer.apple.com/reference/uikit/uitableviewdatasource
    func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSections")
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView numberOfRowsInSection")
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView cellForRowAt: " + indexPath.description)
        
        let id = "BasicCell"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: id)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: id)
        }
        cell?.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("tableView titleForHeaderInSection")
        return "Test Title"
    }
    
    // MARK: - TableViewDelegate
    // https://developer.apple.com/reference/uikit/uitableviewdelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row at " + indexPath.description)
        
        let selectedText = tableView.cellForRow(at: indexPath)?.textLabel?.text ?? ""
        print("selected text: \(selectedText)")
        
        didSelectCallback(selectedText)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("deselected row at " + indexPath.description)
    }
}

class MainTableViewController: UITableViewController {
    
    @IBOutlet weak var specialTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let frame = CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: 200.0)
        let inputTableView = InputTableView(frame: frame)
        
        inputTableView.setupTableView(didSelectCallback: { [weak self] text in
            print("callback with: \(text)")
            self?.specialTextField.text = text
        })
        
        specialTextField.inputView = inputTableView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

