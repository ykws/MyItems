//
//  ViewController.swift
//  MyItems
//
//  Created by Yoshiyuki Kawashima on 2017/10/03.
//  Copyright © 2017 ykws. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

  // MARK: - Properties
  
  let initialItems: [String] = [
    "C",
    "C#",
    "C++",
    "Java",
    "JavaScript",
    "Perl",
    "PHP",
    "Python",
    "Objective-C",
    "Ruby",
    "Rust",
    "Swift"
  ]
  
  var items: [Item] = Array()
  
  // MARK: - Actions
  
  @IBAction func addItem(_ sender: Any) {
    let alert = UIAlertController(title: "Add item", message: "Enter item's name", preferredStyle: .alert)
    alert.addTextField(configurationHandler: nil)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) -> Void in
      if let textFields = alert.textFields {
        for textField in textFields {
          let name = textField.text!
          self.items.append(Item(name: name, deletable: false, completable: false))
          self.items.append(Item(category: name, name: "todo", deletable: true, completable: true))
        }

        self.tableView.reloadData()
      }
    }))
    present(alert, animated: true, completion: nil)
  }
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for name in initialItems {
      items.append(Item(name: name, deletable: false, completable: false))
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - TableView
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    let item = items[indexPath.row]
    cell.textLabel?.text = item.name
    cell.accessoryType = item.complete ? .checkmark : .none
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    items[indexPath.row].toggle()
    tableView.deselectRow(at: indexPath, animated: true)
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    return items[indexPath.row].deletable ? .delete : .none
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      delete(at: indexPath)
    }
  }
  
  override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    if !items[indexPath.row].deletable {
      return UISwipeActionsConfiguration(actions: [])
    }
    
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
      self.delete(at: indexPath)
      completionHandler(true)
    }
    return UISwipeActionsConfiguration(actions: [deleteAction])
  }
  
  // MARK: - Helpers
  
  func delete(at indexPath: IndexPath) {
    let category = items[indexPath.row].category
    var indexPathes: [IndexPath] = Array()
    for (row, item) in items.enumerated() {
      if (item.category == category) {
        indexPathes.append(IndexPath.init(row: row, section: indexPath.section))
      }
    }
    
    guard let minRow = indexPathes.first?.row, let maxRow = indexPathes.last?.row else {
      return
    }
    
    items.removeSubrange(minRow...maxRow)
    tableView.deleteRows(at: indexPathes, with: .fade)
  }
}

