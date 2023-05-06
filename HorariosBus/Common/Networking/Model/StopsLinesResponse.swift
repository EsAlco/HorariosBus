//
//  StopsLinesResponse.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 9/6/22.
//

import Foundation

// MARK: - StopsLinesResponse
struct StopsLinesResponse: Codable {
    let objectIDFieldName: String?
    let uniqueIDField: UniqueIDField
    let globalIDFieldName: String
    let fields: [Field]
    let exceededTransferLimit: Bool
    let features: [FeatureStopsLines]

    enum CodingKeys: String, CodingKey {
        case objectIDFieldName = "objectIdFieldName"
        case uniqueIDField = "uniqueIdField"
        case globalIDFieldName = "globalIdFieldName"
        case fields, exceededTransferLimit, features
    }
}

// MARK: - Feature
struct FeatureStopsLines: Codable {
    let attributes: AttributesStopsLines?
}

// MARK: - Attributes
struct AttributesStopsLines: Codable {
    var numberLine: String?
    var directionLine: String?
    var positionStopLine: Int?
    var nameStop: String?
    var adressStop: String?
    var tariffZoneStop: String?
    var numberStop: String?
    var locationStop: String?

    enum CodingKeys: String, CodingKey {
        case numberLine = "NUMEROLINEAUSUARIO"
        case directionLine = "SENTIDO"
        case positionStopLine = "NUMEROORDEN"
        case nameStop = "DENOMINACION"
        case adressStop = "DIRECCION"
        case tariffZoneStop = "CORONATARIFARIA"
        case numberStop = "CODIGOESTACION"
        case locationStop = "MUNICIPIO"
    }
}


