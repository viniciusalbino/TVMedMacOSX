//
//  LocalDataAccess.swift
//  Shoestock
//
//  Created by Filipe Augusto de Souza Fragoso on 24/01/17.
//  Copyright © 2017 Netshoes. All rights reserved.
//

import Foundation

protocol LocalDataAccess {
    associatedtype DataType
    func save(entity: [DataType], completion: @escaping (_ success: Bool) -> Void)
    func delete(completion: @escaping (_ success: Bool) -> Void)
    func query(completion: @escaping ([DataType]?) -> Void)
}
