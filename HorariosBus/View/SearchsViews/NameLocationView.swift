//
//  NameLocationView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 14/6/22.
//

import SwiftUI

struct NameLocationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var searchNameLocation: String = ""
    @State var nameLocation: String
    @State var nameLocationReal: String
    @StateObject var locations = LocationsList()
    
    @State var showDetailLineStops = false
    @State var showingAlert = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Form{
                    Section{
                        TextField("Burcar por municipio", text: $searchNameLocation)
                            .font(.system(size: 20, weight: .light, design: .rounded))
                            .minimumScaleFactor(0.5)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .stroke(.green, lineWidth: 2)
                                )
                            .padding(.top)
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
                        .padding(.bottom)
                    } header: {
                        Text("Introduzca el nombre del municipio")
                            .frame(alignment: .leading)
                    }
                    .listRowSeparator(.hidden)
                    
                    Section{
                        Picker("", selection: $nameLocation) {
                            ForEach(locations.locationsDictionary.sorted(by: <).filter { location in
                                searchNameLocation.isEmpty ? true : location.key.contains(searchNameLocation)
                            }, id:\.key) { key, value in
                                Text(key)
                                    .onTapGesture {
                                        nameLocation = value
                                        nameLocationReal = key
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
                
                NavigationLink("", destination: DetailLocationStopView(nameLocation: nameLocation, nameLocationReal: nameLocationReal), isActive: $showDetailLineStops)
                    .hidden()
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Label("Atrás", systemImage: "chevron.backward")
                        .font(.subheadline)
                        .foregroundColor(.green)
                        .padding(2)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
                ToolbarItem(placement: .principal) {
                    Text("Buscar por municipio")
                        .padding(2)
                        .font(.system(.title2, design: .rounded))
                        .foregroundColor(.green)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct NameLocationView_Previews: PreviewProvider {
    static var previews: some View {
        NameLocationView(nameLocation: "ROZAS+DE+MADRID,+LAS", nameLocationReal: "Las Rozas de Madrid")
    }
}
