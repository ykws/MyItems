//
//  ViewController.swift
//  MyItems
//
//  Created by Yoshiyuki Kawashima on 2017/10/03.
//  Copyright © 2017 ykws. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var add = UILabel()
  var longPressRecognizer: UILongPressGestureRecognizer!
  //+ボタン
  @IBAction func addlabel(_ sender: Any) {
  
    alert()
    //label()
  }
  
  //ラベルについて
  func label(){
    add = UILabel(frame: CGRect(x: 130, y:250, width: 100, height:20))
    //ラベルの大きさ、座標指定
    //add.text = "labelです"
    //文字を変更
    
    add.backgroundColor = UIColor.lightGray
    
    add.font = UIFont.systemFont(ofSize: 30)
    //文字の大きさ
    
    add.textColor = UIColor.black
    //文字カラー
    
    add.sizeToFit()
    //文字数にあわせてlabelの大きさを変更(サイズが文字にフィットする)
  
    self.view.addSubview(add)
    //実際にviewに見える形でlabelが出現する
  }
  
  func alert(){
    // テキストフィールド付きアラート表示
    
    let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
    
    // OKボタンの設定
    let okAction = UIAlertAction(title: "OK", style: .default, handler: {
      (action:UIAlertAction!) -> Void in
      
      // OKを押した時入力されていたテキストを表示
      if let textFields = alert.textFields {
        
        // アラートに含まれるすべてのテキストフィールドを調べる
        for textField in textFields {
          self.label()
          self.add.text = textField.text!
          self.add.sizeToFit()
          print(textField.text!)
          self.longPressGesture()
        }
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
  
  @objc func longpress(_ sender: UILongPressGestureRecognizer){
  
    // 長押し開始〜
    if(sender.state == UIGestureRecognizerState.began)
    {
      
    } else if (sender.state == UIGestureRecognizerState.ended)
    {
      alert() //長押しタップによってアラートを呼び出しlabelの内容を変更したいです。
      print("ロングタップされたよ。")
    }
    
  }

  func longPressGesture() {
  
    // UILongPressGestureRecognizerインスタンス作成
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longpress(_:)))
    //デリゲート先を自分に設定する。
    //longPressRecognizer.delegate
    // 時間（デフォルト0.5秒）
    longPressGesture.minimumPressDuration = 0.5
    self.add.isUserInteractionEnabled = true
    self.add.addGestureRecognizer(longPressGesture)
    
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}
