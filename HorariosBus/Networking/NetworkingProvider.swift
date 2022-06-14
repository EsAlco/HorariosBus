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
    
    private let kBaseUrl = "https://services5.arcgis.com/UxADft6QPcvFyDU1/arcgis/rest/services/M8_Red/FeatureServer/"
    private let kStatusOk = 200...299
    
    
    // Stop by stop's number
    func getStop(numberStop: String, success: @escaping (_ stopResponse: StopsResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {
        let url = "\(kBaseUrl)0/query?where=CODIGOESTACION=\(numberStop)&outFields=CODIGOESTACION,DENOMINACION,CORONATARIFARIA,LINEAS&f=json"
     
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: StopsResponse.self) {
            response in
            if let stopsResponse = response.value{
                success(stopsResponse)
            } else {
                failure(response.error)
                print(response.error!)
            }
        }
    }
    
    // All stops by stop's number
    func getAllStops(success: @escaping (_ allStopsResponse: StopsResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {
        let url = "\(kBaseUrl)0/query?where=1%3D1&outFields=CODIGOESTACION,DENOMINACION,CORONATARIFARIA,LINEAS&outSR=4326&f=json"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: StopsResponse.self) { response in
            if let allStopsResponse = response.value {
                success(allStopsResponse)
            } else {
                failure(response.error)
                print(response.error!)
                
            }
        }
        
    }
    
    // Stop by line's number
    func getStopByLine(numberLine: String, success: @escaping (_ stopsByLineResponse: StopsLinesResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {
   
        let url = "\(kBaseUrl)3/query?where=NUMEROLINEAUSUARIO='\(numberLine)'&outFields=NUMEROLINEAUSUARIO,SENTIDO,NUMEROORDEN,DENOMINACION,DIRECCION,CORONATARIFARIA,CODIGOESTACION&outSR=4326&f=json"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: StopsLinesResponse.self) {
            response in
            if let stopsByLineResponse = response.value{
                success(stopsByLineResponse)
            } else {
                failure(response.error)
                print(response.error!)
            }
        }
    }
    
    // All stops  by lines
    func getAllStopsByLine(success: @escaping (_ allStopsByLineResponse: StopsLinesResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {
        let url = "\(kBaseUrl)3/query?where=1%3D1&outFields=NUMEROLINEAUSUARIO,SENTIDO,NUMEROORDEN,DENOMINACION,DIRECCION,CORONATARIFARIA,CODIGOESTACION&outSR=4326&f=json"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: StopsLinesResponse.self) { response in
            if let allStopsLinesResponse = response.value {
                success(allStopsLinesResponse)
            } else {
                failure(response.error)
                print(response.error!)
            }
        }
    }
}
