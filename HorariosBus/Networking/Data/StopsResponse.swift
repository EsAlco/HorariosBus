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
//         }/Users/esther/Desktop/Proyectos Xcode/AppPersonales/HorariosBus/HorariosBus/Networking/Data/StopsResponse.swift
//      }
//   ]
//}


struct StopsResponse: Decodable {
    var features: [Features]

    struct Features: Decodable {
        var numberStop: String?
        var nameStop: String?
       // var tariffZoneStop: String?
        var linesStop: String?
        var xGeometryStop: Double?
        var yGeometryStop: Double?

        enum FeaturesKeys: String, CodingKey {
            case attributes
            case geometry
        }
        enum AttributesKeys: String, CodingKey {
            case numberStop = "CODIGOESTACION"
            case nameStop = "DENOMINACION"
           // case tariffZoneStop = "CORONATARIFARIA"
            case linesStop = "LINEAS"
        }

        enum GeometryKeys: String, CodingKey {
            case xGeometryStop = "x"
            case yGeometryStop = "y"
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: FeaturesKeys.self)

            let attributesContainer = try container.nestedContainer(keyedBy: AttributesKeys.self, forKey: .attributes)
            self.numberStop = try attributesContainer.decode(String.self, forKey: .numberStop)
            self.nameStop = try attributesContainer.decode(String.self, forKey: .nameStop)
           // self.tariffZoneStop = try attributesContainer.decode(String.self, forKey: .tariffZoneStop)
            self.linesStop = try attributesContainer.decode(String.self, forKey: .linesStop)

            let geometryContainer = try container.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
            self.xGeometryStop = try geometryContainer.decode(Double.self, forKey: .xGeometryStop)
            self.yGeometryStop = try geometryContainer.decode(Double.self, forKey: .yGeometryStop)
        }
    }
}
