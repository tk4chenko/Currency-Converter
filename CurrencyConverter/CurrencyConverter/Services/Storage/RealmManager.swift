//
//  RealmManager.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    func saveModel<T: Object>(model: T)
    func deleteModel<T: Object>(model: T)
    func loadModels<T: Object>(completion: @escaping ([T]) -> Void)
}

final class RealmManager: RealmManagerProtocol {
    
    func saveModel<T: Object>(model: T) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            try! realm.write {
                realm.add(model, update: .modified)
            }
        }
    }
    
    func deleteModel<T: Object>(model: T) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(model)
            }
        }
    }
    
    func loadModels<T: Object>(completion: @escaping ([T]) -> Void) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            completion(Array(realm.objects(T.self)))
        }
    }
}
