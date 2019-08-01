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
    // Dynamic allows runtime checks
    @objc dynamic var name: String = ""
    @objc dynamic var bgColor: String? // Optional
    //Array like container available in realm
    // Shows the relationships between objects
    let items = List<Item>()
    
    
}
