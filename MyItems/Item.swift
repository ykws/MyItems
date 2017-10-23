//
//  Item.swift
//  MyItems
//
//  Created by Yoshiyuki Kawashima on 2017/10/03.
//  Copyright © 2017 ykws. All rights reserved.
//

struct Item {
  var name: String
  var deletable: Bool
  var completable: Bool
  var complete: Bool
  
  init(name: String, deletable: Bool, completable: Bool) {
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
