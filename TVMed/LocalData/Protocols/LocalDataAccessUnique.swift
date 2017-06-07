//
//  LocalDataAccessUnique.swift
//  Shoestock
//
//  Created by Filipe Augusto de Souza Fragoso on 01/02/17.
//  Copyright © 2017 Netshoes. All rights reserved.
//

import Foundation

protocol LocalDataAccessUnique {
    associatedtype DataType
    func save(entity: DataType, completion: @escaping (_ success: Bool) -> Void)
    func delete(completion: @escaping (_ success: Bool) -> Void)
    func query(completion: @escaping (DataType?) -> Void)
}
