//
//  StopsResponse.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 27/5/22.
//

import Foundation


//{
//   "objectIdFieldName":"OBJECTID",
//   "uniqueIdField":{},
//   "globalIdFieldName":"",
//   "geometryType":"esriGeometryPoint",
//   "spatialReference":{},
//   "fields":[],
//   "features":[
//      {
//         "attributes":{
//            "CODIGOESTACION":"15213",
//            "DENOMINACION":"AV.LAZAREJO-SANTOLINA",
//            "CORONATARIFARIA":"B2",
//            "LINEAS":"628"
//         },
//         "geometry":{
//            "x":421343.26680000033,
//            "y":4485591.7861
//         }
//      }
//   ]
//}
//
//
//struct StopsResponse: Decodable {
//    var features: [Features]
//}
//struct Features: Decodable {
//    var attributes: Attributes
//    var geometry: Geometry
//}
//struct Attributes: Decodable {
//    var numberCode: String?
//    var name: String?
//    var zone: String?
//    var lines: String?
//
//    enum CodingKeys: String, CodingKey {
//        case numberCode = "CODIGOESTACION"
//        case name = "DENOMINACION"
//        case zone = "CORONATARIFARIA"
//        case lines = "LINEAS"
//    }
//    init(from decoder: Decoder) throws{
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.numberCode = try values.decode(String.self, forKey: .numberCode)
//        self.name = try values.decode(String.self, forKey: .name)
//        self.zone = try values.decode(String.self, forKey: .zone)
//        self.lines = try values.decode(String.self, forKey: .lines)
//    }
//}
//
//struct Geometry: Decodable {
//    var x: Double?
//    var y: Double?
//}


struct StopsResponse: Decodable {
    var features: [Features]

    struct Features: Decodable {
        var numberCode: String?
        var name: String?
        var zone: String?
        var lines: String?
        var xGeometry: Double?
        var yGeometry: Double?

        enum FeaturesKeys: String, CodingKey {
            case attributes
            case geometry
        }
        enum AttributesKeys: String, CodingKey {
            case numberCode = "CODIGOESTACION"
            case name = "DENOMINACION"
            case zone = "CORONATARIFARIA"
            case lines = "LINEAS"
        }

        enum GeometryKeys: String, CodingKey {
            case xGeometry = "x"
            case yGeometry = "y"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: FeaturesKeys.self)

            let attributesContainer = try container.nestedContainer(keyedBy: AttributesKeys.self, forKey: .attributes)
            self.numberCode = try attributesContainer.decode(String.self, forKey: .numberCode)
            self.name = try attributesContainer.decode(String.self, forKey: .name)
            self.zone = try attributesContainer.decode(String.self, forKey: .zone)
            self.lines = try attributesContainer.decode(String.self, forKey: .lines)

            let geometryContainer = try container.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
            self.xGeometry = try geometryContainer.decode(Double.self, forKey: .xGeometry)
            self.yGeometry = try geometryContainer.decode(Double.self, forKey: .yGeometry)
        }
    }
}
