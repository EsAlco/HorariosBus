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
     
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: StopsResponse.self) {
            response in
            if let stopsResponse = response.value{
                success(stopsResponse)
            } else {
                failure(response.error)
            }
        }
    }
    
    func getAllStops(success: @escaping (_ allStopsResponse: StopsResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {
        let url = "\(kBaseUrl)where=1%3D1&outFields=CODIGOESTACION,DENOMINACION,CORONATARIFARIA,LINEAS&outSR=4326&f=json"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable(of: StopsResponse.self) {
            response in
            if let allStopsResponse = response.value {
                success(allStopsResponse)
            } else {
                failure(response.error)
            }
        }
        
    }
}
