//
//  Endpoints.swift
//  HorariosBus
//
//  Created by Esther Alcoceba on 5/5/23.
//

import Foundation

struct Endpoints {
    
    static let statusOK = 200 ... 299
    
    static let urlBasic = "https://services5.arcgis.com/UxADft6QPcvFyDU1/arcgis/rest/services"
    
    static let urlInterUrban = urlBasic + "/M8_Red/FeatureServer"
    static let urlTrain = urlBasic + "/M5_Red/FeatureServer"
    
    static let urlInterUrbanStation = urlInterUrban + "/0/query"
    static let urlInterUrbanStops = urlInterUrban + "/3/query"
    
    static let urlTrainStation = urlTrain + "/0/query"

    
}
