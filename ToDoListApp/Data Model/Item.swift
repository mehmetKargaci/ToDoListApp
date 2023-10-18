//
//  item.swift
//  ToDoListApp
//
//  Created by Mehmet on 16.10.23.
//

import Foundation
//we can write Codable for both : Encodable, Decodable

class Item: Codable {
    var title: String = ""
    var done: Bool = false
    
}
