//
//  AllStopResponse.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 7/6/22.
//

import Foundation





//
//struct AllStopsResponse: Decodable {
//    var features: [[Features]]
//
//    struct StopsResponse: Decodable {
//        var features: [Features]
//        
//    struct Features: Decodable {
//        var numberStop: String?
//        var nameStop: String?
//        var tariffZoneStop: String?
//        var linesStop: String?
//        var xGeometryStop: Double?
//        var yGeometryStop: Double?
//
//        enum FeaturesKeys: String, CodingKey {
//            case attributes
//            case geometry
//        }
//        enum AttributesKeys: String, CodingKey {
//            case numberStop = "CODIGOESTACION"
//            case nameStop = "DENOMINACION"
//            case tariffZoneStop = "CORONATARIFARIA"
//            case linesStop = "LINEAS"
//        }
//
//        enum GeometryKeys: String, CodingKey {
//            case xGeometryStop = "x"
//            case yGeometryStop = "y"
//        }
//        init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: FeaturesKeys.self)
//
//            let attributesContainer = try container.nestedContainer(keyedBy: AttributesKeys.self, forKey: .attributes)
//            self.numberStop = try attributesContainer.decode(String.self, forKey: .numberStop)
//            self.nameStop = try attributesContainer.decode(String.self, forKey: .nameStop)
//            self.tariffZoneStop = try attributesContainer.decode(String.self, forKey: .tariffZoneStop)
//            self.linesStop = try attributesContainer.decode(String.self, forKey: .linesStop)
//
//            let geometryContainer = try container.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
//            self.xGeometryStop = try geometryContainer.decode(Double.self, forKey: .xGeometryStop)
//            self.yGeometryStop = try geometryContainer.decode(Double.self, forKey: .yGeometryStop)
//        }
//    }
//}
