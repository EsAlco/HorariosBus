//
//  DataController.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 25/4/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "HorariosBus")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
