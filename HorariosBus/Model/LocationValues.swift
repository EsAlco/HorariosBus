//
//  LocationValues.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 7/6/22.
//

import Foundation

struct Location: Identifiable {
    let id = UUID()
    let nameStop: String
    let numberStop: String
//    let tariffZoneStop: String
    let linesStop: String
    let xGeometryStop: Double
    let yGeometryStop: Double
}
