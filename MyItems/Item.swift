//
//  Item.swift
//  MyItems
//
//  Created by Yoshiyuki Kawashima on 2017/10/03.
//  Copyright © 2017 ykws. All rights reserved.
//

struct Item {
  var category: String
  var name: String
  var deletable: Bool
  var completable: Bool
  var complete: Bool
  
  init(name: String, deletable: Bool, completable: Bool) {
    self.init(category: name, name: name, deletable: deletable, completable: completable)
  }
  
  init(category: String, name: String, deletable: Bool, completable: Bool) {
    self.category = category
    self.name = name;
    self.deletable = deletable
    self.completable = completable
    complete = false
  }

  mutating func toggle() {
    if completable {
      complete = !complete
    }
  }
}
