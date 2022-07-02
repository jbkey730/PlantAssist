//
//  Database.swift
//  PlantAssist
//
//  Created by Jacob Lamkey on 6/30/22.
//

import Foundation
import SwiftUI

struct dataBase: Decodable {
    let error: Bool
    let message: String
    let data:[postDataBase]
}

struct postDataBase: Decodable {
    let ID: Int
    let title: String
    let post:String
}
