//
//  SearchBusStop.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 25/4/22.
//

import SwiftUI

struct SearchBusStop: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    // TODO: tipos de buscador
                    HStack{
                        Spacer()
                        Button{
                            //TODO: Busqueda por dirección
                        }label: {
                            Image(systemName: "paperplane.circle.fill")
                                .foregroundColor(.green)
                                . font(.system(size: 50))
                        }
                        Spacer()
                        Button{
                            //TODO: Busqueda por mapa
                        }label: {
                            Image(systemName: "map.circle.fill")
                                .foregroundColor(.green)
                                . font(.system(size: 50))
                        }
                        Spacer()
                        Button{
                            //TODO: Busqueda por número de parada
                        }label: {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.green)
                                . font(.system(size: 50))
                        }
                        Spacer()
                    }
                }
                Section{
                    // TODO: buscador
                    VStack{
                        HStack{
                            TextField("", text: $searchText)
                            
                            Button{
                                // TODO: buscar en la base de datos
                            } label: {
                                Text("Buscar")
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(.green)
                                    .cornerRadius(7)
                            }
                        }
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .stroke(.gray, lineWidth: 1)
                        )
                        
                        Text("Busca por el código de la parada. \nLo encontrarás en la marquesina.")
                            .font(.system(size: 15))
                            .multilineTextAlignment(.center)
                            .frame(height: 40)
                        
                        Text("También tiene las opciones de arriba.")
                            .font(.system(size: 12))
                    }
                }
                .padding(3)
            }
        }
    }
}

struct SearchBusStop_Previews: PreviewProvider {
    static var previews: some View {
        SearchBusStop()
    }
}
