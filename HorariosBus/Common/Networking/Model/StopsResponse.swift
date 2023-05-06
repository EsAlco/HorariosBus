//
//  StopsResponse.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 27/5/22.
//

import Foundation

// MARK: - Welcome
struct StopsResponse: Codable {
    let objectIDFieldName: String
    let uniqueIDField: UniqueIDField
    let globalIDFieldName, geometryType: String
    let spatialReference: SpatialReference
    let fields: [Field]
    let features: [Feature]

    enum CodingKeys: String, CodingKey {
        case objectIDFieldName = "objectIdFieldName"
        case uniqueIDField = "uniqueIdField"
        case globalIDFieldName = "globalIdFieldName"
        case geometryType, spatialReference, fields, features
    }
}

// MARK: - Feature
struct Feature: Codable {
    let attributes: Attributes?
    let geometry: Geometry?
}

// MARK: - Attributes
struct Attributes: Codable {
    let numberStop, nameStop, linesStop: String?
    let tariffZoneStop: String?

    enum CodingKeys: String, CodingKey {
        case numberStop = "CODIGOESTACION"
        case nameStop = "DENOMINACION"
        case linesStop = "LINEAS"
        case tariffZoneStop = "CORONATARIFARIA"
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let xGeometryStop, yGeometryStop: Double
    
    enum CodingKeys: String, CodingKey {
        case xGeometryStop = "x"
        case yGeometryStop = "y"
    }
}

// MARK: - Field
struct Field: Codable {
    let name, type, alias, sqlType: String
    let length: Int
    let domain, defaultValue: JSONNull?
}

// MARK: - SpatialReference
struct SpatialReference: Codable {
    let wkid, latestWkid: Int
}

// MARK: - UniqueIDField
struct UniqueIDField: Codable {
    let name: String
    let isSystemMaintained: Bool
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
