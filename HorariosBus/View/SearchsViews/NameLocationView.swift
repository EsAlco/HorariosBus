//
//  NameLocationView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 14/6/22.
//

import SwiftUI

struct NameLocationView: View {
    
    @State var searchNameLocation: String = ""
    @State var nameLocation: String
    @StateObject var locations = LocationsList()
    
    @State var isCharged = false
    
    @State var showDetailLineStops = false
    @State var showingAlert = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Form{
                    Section{
                        TextField("Burcar por numero de línea", text: $searchNameLocation)
                            .font(.system(size: 20, weight: .light, design: .rounded))
                            .minimumScaleFactor(0.5)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .stroke(.green, lineWidth: 2)
                                )
                        HStack{
                            Spacer()
                            Text("Buscar")
                                .padding()
                                .background(.green)
                                .cornerRadius(15)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .onTapGesture {
                                    self.showDetailLineStops.toggle()
                                }
                            Spacer()
                        }
                    } header: {
                        Text("Introduzca el nombre del municipio")
                            .frame(alignment: .leading)
                    }
                    .padding()
                    .listRowSeparator(.hidden)
                    .multilineTextAlignment(.center)
                    
                    Section{
                        Picker("", selection: $nameLocation) {
                            ForEach(locations.locationsDictionary.sorted(by: <).filter { location in
                                searchNameLocation.isEmpty ? true : location.key.contains(searchNameLocation)
                            }, id:\.key) { key, value in
                                Text(key)
                                    .onTapGesture {
                                        nameLocation = value
                                        self.showDetailLineStops.toggle()
                                    }
                            }
                        }
                        .pickerStyle(.inline)
                        .labelsHidden()
                    }header: {
                        Text("Seleccione un municipio de la lista")
                    }
                }
                
                NavigationLink("", destination: DetailLineStopsView(directionLine: "", numberLine: "", numberStop: ""), isActive: $showDetailLineStops)
                    .hidden()
            }
        }
        .navigationBarHidden(true)
    }
}

struct NameLocationView_Previews: PreviewProvider {
    static var previews: some View {
        NameLocationView(nameLocation: "ROZAS+DE+MADRID,+LAS")
    }
}
