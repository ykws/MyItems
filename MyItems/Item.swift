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
  var cellcolor: Bool
  
  init(name: String, deletable: Bool, completable: Bool, cellcolor: Bool) {
    self.init(category: name, name: name, deletable: deletable, completable: completable, cellcolor: cellcolor)
  }
  
  init(category: String, name: String, deletable: Bool, completable: Bool, cellcolor: Bool) {
    self.category = category
    self.name = name;
    self.deletable = deletable
    self.completable = completable
    complete = false
    self.cellcolor = cellcolor
  }

  mutating func toggle() {
    if completable {
      complete = !complete
    }
  }
}
