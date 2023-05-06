//
//  HorariosBusTests.swift
//  HorariosBusTests
//
//  Created by Esther Alcoceba Gutiérrez de León on 20/7/22.
//

import XCTest
@testable import HorariosBus
import Alamofire

class HorariosBusTests: XCTestCase {

    var sut: NetworkingProvider!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkingProvider()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testValidApiCallGetsHTTPStatusCode200() throws {
        let urlString = "https://services5.arcgis.com/UxADft6QPcvFyDU1/arcgis/rest/services/M8_Red/FeatureServer/0/query?where=CODIGOESTACION='11828'&outFields=CODIGOESTACION,DENOMINACION,CORONATARIFARIA,LINEAS&f=json"
        let url = URL(string: urlString)!
        let expectation = XCTestExpectation(description: "Status Code: 200, OK")
        var request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                XCTFail("Error en la llamada a la API: \(error)")
            }
            if let httpResponse = response as? HTTPURLResponse {
                XCTAssertEqual(httpResponse.statusCode, 200)
            }else{
                XCTFail("Respuesta de la API incorrecta")
            }
            expectation.fulfill()
        }.resume()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testValidGetInterUrbanStopByNumber() throws {
        let numberStop = "11282"
        var components = URLComponents(string: Endpoints.urlInterUrbanStation)!
        components.queryItems = [
            URLQueryItem(name: "where", value: "CODIGOESTACION=\(numberStop)"),
            URLQueryItem(name: "outFields", value: "CODIGOESTACION,DENOMINACION,CORONATARIFARIA,LINEAS"),
            URLQueryItem(name: "f", value: "json")
        ]
        
        let url = components.url!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
    }
}
