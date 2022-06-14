//
//  StopsLinesResponse.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 9/6/22.
//

import Foundation

//{
//   "objectIdFieldName":"OBJECTID",
//   "uniqueIdField":{
//},
//   "globalIdFieldName":"",
//   "fields":[
//],
//   "exceededTransferLimit":true,
//   "features":[
//      {
//         "attributes":{
//            "NUMEROLINEAUSUARIO":"546",
//            "SENTIDO":"1",
//            "NUMEROORDEN":3,
//            "DENOMINACION":"CASILLAS-LA RAMA",
//            "DIRECCION":"Calle DE La Rama N 3",
//            "CORONATARIFARIA":"SZ",
//            "CODIGOESTACION":"19034"
//         }
//      }
//   ]
//}


struct StopsLinesResponse: Decodable {
    var features: [Features]

    struct Features: Decodable {
        var numberLine: String
        var directionLine: String
        var positionStopLine: Int
        var nameStop: String
        var adressStop: String
        var tariffZoneStop: String?
        var numberStop: String

        enum FeaturesKeys: String, CodingKey {
            case attributes
        }
        enum AttributesKeys: String, CodingKey {
            case numberLine = "NUMEROLINEAUSUARIO"
            case directionLine = "SENTIDO"
            case positionStopLine = "NUMEROORDEN"
            case nameStop = "DENOMINACION"
            case adressStop = "DIRECCION"
            case tariffZoneStop = "CORONATARIFARIA"
            case numberStop = "CODIGOESTACION"
            
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: FeaturesKeys.self)

            let attributesContainer = try container.nestedContainer(keyedBy: AttributesKeys.self, forKey: .attributes)
            self.numberLine = try attributesContainer.decode(String.self, forKey: .numberLine)
            self.directionLine = try attributesContainer.decode(String.self, forKey: .directionLine)
            self.positionStopLine = try attributesContainer.decode(Int.self, forKey: .positionStopLine)
            self.nameStop = try attributesContainer.decode(String.self, forKey: .nameStop)
            self.adressStop = try attributesContainer.decode(String.self, forKey: .adressStop)
            self.numberStop = try attributesContainer.decode(String.self, forKey: .numberStop)
            
            if let tariffZoneStop = try attributesContainer.decodeIfPresent(String.self, forKey: .tariffZoneStop) {
                self.tariffZoneStop = tariffZoneStop
            } else {
                self.tariffZoneStop = ""
            }
        }
    }
}
