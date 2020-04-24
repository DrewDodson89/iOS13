//
//  Item.swift
//  Todoey
//
//  Created by Drew Dodson on 4/23/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var isChecked: Bool = false
    var parentCateogry = LinkingObjects(fromType: Category.self, property: "items")
    
}
