//
//  ViewModel.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 13/5/22.
//

import Foundation


class ViewModel: ObservableObject {
    func fetch() {
        guard let url = URL(string: "https://services5.arcgis.com/UxADft6QPcvFyDU1/arcgis/rest/services/M8_Red/FeatureServer/0/query?where=1%3D1&outFields=IDESTACION,DENOMINACION,CODIGOESTACION,LINEAS,CORONATARIFARIA&outSR=4326&f=json"
        )else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            //TODO: Transformable JSON
        }
    }
    
    
}
