//
//  AddStopViewModel.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 2/6/22.
//

import CoreData

struct AddStopViewModel {
    func fetchStop(for objectId: NSManagedObjectID, context: NSManagedObjectContext) -> Stop? {
        guard let stop = context.object(with: objectId) as? Stop else {
            return nil
        }
        return stop
    }
    
    func saveStop(stopId: NSManagedObjectID?, with stopValues: StopValues, in context: NSManagedObjectContext){
        let stop: Stop
        if let objectId = stopId,
           let fetchedStop = fetchStop(for: objectId, context: context) {
            stop = fetchedStop
        } else {
            stop = Stop(context: context)
        }
        stop.name = stopValues.name
        stop.number = stopValues.number
        stop.tariffZone = stopValues.tariffZone
        stop.lines = stopValues.lines
        stop.alias = stopValues.alias
        stop.feature = stopValues.feature
        stop.typeTransport = stopValues.typeTransport
        
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
