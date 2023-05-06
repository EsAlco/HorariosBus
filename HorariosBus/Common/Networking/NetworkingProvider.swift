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
    
    
    // Stop by stop's number
    func getStop(numberStop: String, success: @escaping (_ stopResponse: StopsResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {
        let url = Endpoints.urlInterUrbanStation
        let parameters = [
            "where": "CODIGOESTACION=\(numberStop)",
            "outFields": "CODIGOESTACION,DENOMINACION,CORONATARIFARIA,LINEAS",
            "f": "json"
            ]
     
        AF.request(url, method: .get, parameters: parameters).validate(statusCode: Endpoints.statusOK).responseDecodable (of: StopsResponse.self) {
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
        let url = Endpoints.urlInterUrbanStation
        let parameters: [String: Any] = [
            "where": "1=1",
            "outFields": "CODIGOESTACION,DENOMINACION,CORONATARIFARIA,LINEAS",
            "outSR": "4326",
            "f": "json"
        ]

        AF.request(url, method: .get, parameters: parameters).validate(statusCode: Endpoints.statusOK).responseDecodable (of: StopsResponse.self) { response in
            if let allStopsResponse = response.value {
                success(allStopsResponse)
                print("💚\(response)")
            } else {
                failure(response.error)
                print(response.error!)
                
            }
        }
        
    }
    
    // Stop by line's number
    func getStopByLine(numberLine: String, success: @escaping (_ stopsByLineResponse: StopsLinesResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {
   
        let url = Endpoints.urlInterUrbanStops
        let parameters: Parameters = [
            "where": "NUMEROLINEAUSUARIO=\(numberLine)",
            "outFields": "NUMEROLINEAUSUARIO,SENTIDO,NUMEROORDEN,DENOMINACION,DIRECCION,CORONATARIFARIA,CODIGOESTACION",
            "outSR": "4326",
            "f": "json"
        ]
        
        AF.request(url, method: .get, parameters: parameters).validate(statusCode: Endpoints.statusOK).responseDecodable (of: StopsLinesResponse.self) {
            response in
            if let stopsByLineResponse = response.value{
                success(stopsByLineResponse)
            } else {
                failure(response.error)
                print(response.error!)
            }
        }
    }
    
    // All stops by lines
    func getAllStopsByLine(success: @escaping (_ allStopsByLineResponse: StopsLinesResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {

        let url = Endpoints.urlInterUrbanStops
        let parameters: Parameters = [
            "where": "1%3D1",
            "outFields": "NUMEROLINEAUSUARIO,SENTIDO,NUMEROORDEN,DENOMINACION,DIRECCION,CORONATARIFARIA,CODIGOESTACION",
            "outSR": "4326",
            "f": "json"
        ]
        
        AF.request(url, method: .get, parameters: parameters).validate(statusCode: Endpoints.statusOK).responseDecodable (of: StopsLinesResponse.self) { response in
            if let allStopsLinesResponse = response.value {
                success(allStopsLinesResponse)
            } else {
                failure(response.error)
                print(response.error!)
            }
        }
    }
    
    // Stop by location
    func getStopByLocation(nameLocation: String, success: @escaping (_ stopsByLocationResponse: StopsLinesResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {
   
        let url = Endpoints.urlInterUrbanStops
        let parameters: Parameters = [
            "where": "MUNICIPIO=\(nameLocation)",
            "outFields": "NUMEROLINEAUSUARIO,SENTIDO,NUMEROORDEN,DENOMINACION,DIRECCION,CORONATARIFARIA,CODIGOESTACION,MUNICIPIO",
            "outSR": "4326",
            "f": "json"
        ]
        
        AF.request(url, method: .get, parameters: parameters).validate(statusCode: Endpoints.statusOK).responseDecodable (of: StopsLinesResponse.self) {
            response in
            if let stopsByLocationResponse = response.value{
                success(stopsByLocationResponse)
            } else {
                failure(response.error)
                print(response.error!)
            }
        }
    }
    
    func getStopTrain(numberLine: String, success: @escaping (_ stopTrainResponse: StopsResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        let url = Endpoints.urlTrainStation
        let parameters: Parameters = [
            "where": "CODIGOESTACION=\(numberLine)",
            "outFields": "CODIGOESTACION,DENOMINACION,CORONATARIFARIA,LINEAS",
            "outSR": "4326",
            "f": "json"
        ]
        
        AF.request(url, method: .get, parameters: parameters).validate(statusCode: Endpoints.statusOK).responseDecodable (of: StopsResponse.self) {
            response in
            if let stopTrainResponse = response.value {
                success(stopTrainResponse)
            } else {
                failure(response.error)
                print(response.error!)
            }
        }
    }
    
    func getAllStopsTrain(success: @escaping (_ allStopsTrainResponse: StopsResponse) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        let url = Endpoints.urlTrainStation
        let parameters: Parameters = [
            "where": "1%3D1",
            "outFields": "CODIGOESTACION,DENOMINACION,CORONATARIFARIA,LINEAS",
            "outSR": "4326",
            "f": "json"
        ]
        
        AF.request(url, method: .get, parameters: parameters).validate(statusCode: Endpoints.statusOK).responseDecodable (of: StopsResponse.self) {
            response in
            if let allStopsTrainResponse = response.value {
                success(allStopsTrainResponse)
            } else {
                failure(response.error)
                print(response.error!)
            }
        }
    }
}
