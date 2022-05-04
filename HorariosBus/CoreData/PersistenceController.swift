//
//  PersistenceController.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 25/4/22.
//

import Foundation
import CoreData

struct PersistenceController {
    
    // Singlenton para que lo use todo nuestra app
    static let shared = PersistenceController()
    
    // Almacenamiento para Core Data
    let container: NSPersistentContainer
    
    // Test de configuración para las previews de SwiftUI
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        
        // Creación de 10 ejemplos
        for _ in 0..<10 {
            let busStop = BusStop(context: controller.container.viewContext)
            busStop.name = "Av. Lazarejo"
            busStop.number = 15678
        }
        return controller
    }()
    
    
    // Inicializador para cargar Core Data, opcionalmente capaz de usar un almacen en memoria
    init(inMemory: Bool = false){
        
        // Nombramos al modelo
        container = NSPersistentContainer(name: "HorariosBus")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

