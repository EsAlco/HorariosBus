//
//  Stop.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 13/5/22.
//

import Foundation

struct StopValues: Hashable, Codable {
    var name: String
    var number: String
    var tariffZone: String
    var lines: String
    var alias: String
    var feature: Bool
}
