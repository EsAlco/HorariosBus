//
//  Locations.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 15/6/22.
//

import Foundation

class LocationsList: ObservableObject {
    @Published var locationsDictionary = [
        "Rozas de Madrid, Las":"ROZAS+DE+MADRID,+LAS",
        "Majadahonda":"MAJADAHONDA",
        "Torrelodones":"TORRELODONES",
        "Tiemblo, El":"TIEMBLO,+EL",
        "Pozuelo":"POZUELO",
        "Casillas":"CASILLAS",
        "Cebreros":"CEBREROS",
        "Hoyo de Pinares, El":"HOYO+DE+PINARES,+EL",
        "Navas del Marqués, Las":"NAVAS+DEL+MARQUES,+LAS",
        "Peguerinos":"PEGUERINOS",
        "Sotillo de la Adrada":"SOTILLO+DE+LA+ADRADA",
        "Alcázar de San Juan":"ALCAZR+DE+SAN+JUAN",
        "Argamasilla de Alba":"ARGAMOSILLA+DE+ALBA",
        "Fuente del Fresno":"FUENTE+DEL+FRESNO",
        "Herencia":"HERENCIA",
        "Labores, Las":"LABORES,+LAS"
    ]
}

