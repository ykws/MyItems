//
//  Item.swift
//  MyItems
//
//  Created by Yoshiyuki Kawashima on 2017/10/03.
//  Copyright © 2017 ykws. All rights reserved.
//

struct Item {
  var name: String
  var complete: Bool
  
  init(name: String) {
    self.name = name;
    complete = false
  }
  
  mutating func toggle() {
    complete = !complete
  }
}
