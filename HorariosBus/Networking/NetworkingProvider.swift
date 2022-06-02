//
//  NetworkingProvider.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 27/5/22.
//

import Foundation
import Alamofire
import SwiftUI

final class NetworkingProvider {
    static let shared = NetworkingProvider()
    
    private let kBaseUrl = "https://services5.arcgis.com/UxADft6QPcvFyDU1/arcgis/rest/services/M8_Red/FeatureServer/0/query?"
    private let kStatusOk = 200...299
    
    func getStop(numberStop: String, success: @escaping (_ stopResponse: StopsResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {
        let url = "\(kBaseUrl)where=CODIGOESTACION=\(numberStop)&outFields=CODIGOESTACION,DENOMINACION,CORONATARIFARIA,LINEAS&f=json"
//        var name = ""
//        var numberCode = ""
//        var zone = ""
//        var lines = ""
//        var xGeometry = 0.0
//        var yGeometry = 0.0
     
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: StopsResponse.self) {
            response in
            if let stopsResponse = response.value{
                success(stopsResponse)
//                for feature in stopResponse{
//                    numberCode = feature.numberCode ?? ""
//                    name = feature.name ?? ""
//                    zone = feature.zone ?? ""
//                    lines = feature.lines ?? ""
//                    xGeometry = feature.xGeometry ?? 0.0
//                    yGeometry = feature.yGeometry ?? 0.0
//                    let stopFeatures: (numberCode: String, name: String, zone: String, lines: String, xGeometry: Double, yGeometry: Double) =
//                            (numberCode, name, zone, lines, xGeometry, yGeometry)
//                }
            } else {
                failure(response.error)
            }
        }
    }
}
