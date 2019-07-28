//
//  Category.swift
//  Todoey
//
//  Created by Bruno Wu on 27/07/2019.
//  Copyright © 2019 Bruno Wu. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    //Array like container available in realm
    let items = List<Item>()
    
    
}
