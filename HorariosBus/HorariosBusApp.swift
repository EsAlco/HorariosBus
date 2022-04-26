//
//  HorariosBusApp.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 25/4/22.
//

import SwiftUI

@main
struct HorariosBusApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
