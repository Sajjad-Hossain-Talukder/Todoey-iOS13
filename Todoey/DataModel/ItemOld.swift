//
//  Item.swift
//  Todoey
//
//  Created by Xotech on 09/01/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation


struct ItemOld : Encodable, Decodable {
    let title : String
    var done : Bool = false
}
