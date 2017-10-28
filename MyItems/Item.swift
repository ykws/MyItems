//
//  Item.swift
//  MyItems
//
//  Created by Yoshiyuki Kawashima on 2017/10/03.
//  Copyright © 2017 ykws. All rights reserved.
//

struct Item {
  var title: String
  var subTitle: String
  var deletable: Bool
  var completable: Bool
  var complete: Bool
  
  init(title: String, subTitle: String, deletable: Bool, completable: Bool) {
    self.title = title;
    self.subTitle = subTitle
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
