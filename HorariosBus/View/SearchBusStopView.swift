//
//  SearchBusStopView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 25/4/22.
//

import SwiftUI

struct SearchBusStopView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: BusStop.entity(), sortDescriptors: []) var busStops: FetchedResults<BusStop>
    
    @State var searchNumberStop: Int
    @State var searchTextNumberStop: String
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    
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
                            TextField("Código de parada", text: $searchTextNumberStop)
                                .keyboardType(.numbersAndPunctuation)
                                .disableAutocorrection(true)
                        
                            withAnimation {
                                Text("Buscar")
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(.green)
                                    .cornerRadius(7)
                                    .onTapGesture {
                                        if searchNumberStop.words.isEmpty{
                                            // TODO: mensaje de error
                                        }
                                        // TODO: buscar en la base de datos
                                    }
                            }
                            
                        }
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .stroke(.gray, lineWidth: 1)
                        )
                    }
                    HStack{
                        Spacer()
                        Text("Busca por el código de la parada. \nLo encontrarás en la marquesina.")
                            .font(.system(size: 16))
                            .frame(height: 40)
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Text("También tienes las opciones de arriba.")
                            .font(.system(size: 12))
                        Spacer()
                    }
                }
                .padding(3)
                .listRowSeparator(.hidden)
            }
        }
    }
}

struct SearchBusStopView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBusStopView(searchNumberStop: 12345, searchTextNumberStop: "12345")
    }
}
