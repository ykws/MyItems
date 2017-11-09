//
//  ViewController.swift
//  MyItems
//
//  Created by Yoshiyuki Kawashima on 2017/10/03.
//  Copyright © 2017 ykws. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
  
  @IBOutlet weak var mytableView: UITableView!
  
  
  let initialItems: [String] = []
  var kei: [Item] = Array()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mytableView.delegate = self
    mytableView.dataSource = self
    title = "内容"
    mytableView.tableFooterView  = UIView()
    self.mytableView.separatorColor = UIColor.black
    mytableView.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 1.0, alpha: 1.0)
    
    for name in initialItems {
      kei.append(Item(name: name, deletable: false,completable: false, cellcolor: false))
      kei.append(Item(name: name, deletable: false, completable: false, cellcolor: false))
    }
    
  }
  
  
  
  @IBAction func addbtr(_ sender: Any) {
    
    
    let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
    
    // OKボタンの設定
    let okAction = UIAlertAction(title: "OK", style: .default, handler: {
      (action:UIAlertAction!) -> Void in
      
      // OKを押した時入力されていたテキストを表示
      if let textFields = alert.textFields {
        
        // アラートに含まれるすべてのテキストフィールドを調べる
        for textField in textFields {
          //self.items.append(Item(name: textField.text!))
          //self.kei.append(Item(name: textField.text!,deletable: true,completable: false, cellcolor: true)) //insertは上に追加されappendは下に追加される
          let name = textField.text!
          self.kei.append(Item(name: name, deletable: true, completable: false, cellcolor: true))
          self.kei.append(Item(category: name, name: "cell 追加　ボタン", deletable: true, completable: true, cellcolor: false))
        }
        //self.kei.append(Item(name: "cell 追加　ボタン",deletable: false,completable: false, cellcolor: false))
        self.mytableView.reloadData()
        
      }
    })
    alert.addAction(okAction)
    
    // キャンセルボタンの設定
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    
    // テキストフィールドを追加
    alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
      textField.placeholder = "テキスト"
    })
    
    
    alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
    
    // アラートを画面に表示
    self.present(alert, animated: true, completion: nil)
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return kei.count
  }
  
  
  func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
    
    switch indexPath.row {
    // 選択不可にしたい場合は"nil"を返す
    case 1:
      return indexPath;
      
    // 選択可にしたい場合は"indexPath"を返す
    default:
      return nil;
    }
  }
  
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return indexPath
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    //追加した内容に対して
    let item = kei[indexPath.row]
    cell.textLabel?.text = item.name
    if kei[indexPath.row].cellcolor {
      cell.accessoryType = .none
      //kei[indexPath.row].color21()
      cell.textLabel?.textColor = UIColor.black
      cell.backgroundColor = UIColor(red: 1.5, green: 0.3, blue: 0.5, alpha: 1.0)
      mytableView.estimatedRowHeight = 30
      mytableView.rowHeight = 35
      return cell
    }
    
    if cell.textLabel?.text != "cell 追加　ボタン" {
      cell.accessoryType = item.complete ? .checkmark : .none
      cell.textLabel?.textColor = UIColor.black
      cell.backgroundColor = UIColor.yellow
      tableView.rowHeight = 35
    }else {
      cell.accessoryType = .none
      cell.textLabel?.textColor = UIColor.red
      cell.backgroundColor = UIColor.black
      tableView.rowHeight = 40
    }
    
    
    
    return cell
  }
  
  
  /*if kei.count > (indexPath.row + 1)使うには  func tableView(_ tableView: UITableView, didSelectRowAtIndexPath: IndexPath){　を  func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) -> IndexPath? {*/
  func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) -> IndexPath? {
    
    let cell = tableView.cellForRow(at: indexPath)
    
    if cell?.textLabel?.text != "cell 追加　ボタン"{
      kei[indexPath.row].toggle()
      tableView.deselectRow(at: indexPath, animated: true)
      tableView.reloadRows(at: [indexPath], with: .none)
      return nil
    }else {
      let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
      
      // OKボタンの設定
      let okAction = UIAlertAction(title: "OK", style: .default, handler: {
        (action:UIAlertAction!) -> Void in
        
        // OKを押した時入力されていたテキストを表示
        if let textFields = alert.textFields {
          
          // アラートに含まれるすべてのテキストフィールドを調べる
          for textField in textFields {
            let name = textField.text!
            self.kei.insert(Item(category: name,name: textField.text!,deletable: false,completable: true, cellcolor: false), at: indexPath.row)//indexPath.rowで1,2,3,4のような順になる
            //self.kei.insert(textField.text!, at:self.kei.count - 1)
          }
          self.mytableView.reloadData()
          
        }
      })
      alert.addAction(okAction)
      
      // キャンセルボタンの設定
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alert.addAction(cancelAction)
      
      // テキストフィールドを追加
      alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
        textField.placeholder = "テキスト"
      })
      
      
      alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
      
      // アラートを画面に表示
      self.present(alert, animated: true, completion: nil)
      
      return indexPath
    }
    
  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    return kei[indexPath.row].deletable ? .delete : .none
  }
  //cellの削除について
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      //self.kei.remove(at: indexPath.row)
      //tableView.deleteRows(at: [indexPath], with: .fade)
      delete(indexPath)
    }
    
  }
  
  // MARK: - Helpers
  
  func delete(at indexPath: IndexPath) {
    let category = kei[indexPath.row].category
    var indexPathes: [IndexPath] = Array()
    for (row, kei) in kei.enumerated() {
      if (kei.category == category) {
        indexPathes.append(IndexPath.init(row: row, section: indexPath.section))
      }
    }
    
    guard let minRow = indexPathes.first?.row, let maxRow = indexPathes.last?.row else {
      return
    }
    
    kei.removeSubrange(minRow...maxRow)
    mytableView.deleteRows(at: indexPathes, with: .fade)
  }
  
  //func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let delete = UIContextualAction(style: .normal,title: "削除", handler: { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
      self.delete(at: indexPath)
      success(true)
    })
    
    let edit = UIContextualAction(style: .normal,title: "編集", handler: { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
      
      let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
      
      // OKボタンの設定
      let okAction = UIAlertAction(title: "OK", style: .default, handler: {
        (action:UIAlertAction!) -> Void in
        
        // OKを押した時入力されていたテキストを表示
        if let textFields = alert.textFields {
          
          // アラートに含まれるすべてのテキストフィールドを調べる
          for textField in textFields {
            let name = textField.text!
            self.kei[indexPath.row] = (Item(category: name,name: textField.text!,deletable: true,completable :true, cellcolor: false))
            //self.kei.append(textField.text!)
          }
          self.mytableView.reloadData()
          
        }
      })
      alert.addAction(okAction)
      
      // キャンセルボタンの設定
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alert.addAction(cancelAction)
      
      // テキストフィールドを追加
      alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
        textField.placeholder = "テキスト"
      })
      
      
      alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
      
      // アラートを画面に表示
      self.present(alert, animated: true, completion: nil)
      print("edit")
      
      success(true)
    })
    
    delete.backgroundColor = .red
    edit.backgroundColor = .blue
    
    let swipeAction = UISwipeActionsConfiguration(actions: [delete])
    swipeAction.performsFirstActionWithFullSwipe = false
    
    return UISwipeActionsConfiguration(actions: [delete,edit])
  }
  
  
  
  // trueを返すことでCellのアクションを許可しています
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    
    if kei.count > (indexPath.row + 1) {
      return true
    }else{
      return false
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  //左から右へスワイプ
  func tableView(_ tableView: UITableView,
                 leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    if !kei[indexPath.row].deletable {
      return UISwipeActionsConfiguration(actions: [])
    }
    
    
    
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
      
      self.delete(at: indexPath)
      completionHandler(true)
    }
    
    let edit = UIContextualAction(style: .normal,title: "編集", handler: { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
      
      let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
      
      // OKボタンの設定
      let okAction = UIAlertAction(title: "OK", style: .default, handler: {
        (action:UIAlertAction!) -> Void in
        
        // OKを押した時入力されていたテキストを表示
        if let textFields = alert.textFields {
          
          // アラートに含まれるすべてのテキストフィールドを調べる
          for textField in textFields {
            let name = textField.text!
            self.kei[indexPath.row] = (Item(category:name,name: textField.text!,deletable: true,completable: true, cellcolor: false))
            //self.kei.append(textField.text!)
          }
          self.mytableView.reloadData()
          
        }
      })
      alert.addAction(okAction)
      
      // キャンセルボタンの設定
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alert.addAction(cancelAction)
      
      // テキストフィールドを追加
      alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
        textField.placeholder = "テキスト"
      })
      
      
      alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
      
      // アラートを画面に表示
      self.present(alert, animated: true, completion: nil)
      print("edit")
      
      success(true)
    })
    
    deleteAction.backgroundColor = .orange
    edit.backgroundColor = .blue
    
    return UISwipeActionsConfiguration(actions: [deleteAction,edit])
    
  }
  
}

