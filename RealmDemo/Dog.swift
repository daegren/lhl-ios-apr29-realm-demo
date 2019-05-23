//
//  Dog.swift
//  RealmDemo
//
//  Created by David Mills on 2019-05-23.
//  Copyright © 2019 David Mills. All rights reserved.
//

import Foundation
import RealmSwift

class Dog: Object {
  @objc dynamic var name = ""
  @objc dynamic var age = 0
}
