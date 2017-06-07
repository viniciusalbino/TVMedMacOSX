//
//  ObjectConversion.swift
//  Shoestock
//
//  Created by Filipe Augusto de Souza Fragoso on 01/02/17.
//  Copyright © 2017 Netshoes. All rights reserved.
//

import Foundation
import RealmSwift

protocol ObjectConversion {
    associatedtype RealmObject: Object
    associatedtype Entity
    func convertToObject(entity: Entity) -> RealmObject
    func convertToEntity(object: RealmObject) -> Entity
}
