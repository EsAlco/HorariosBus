//
//  SearchBusStopView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 25/4/22.
//

import SwiftUI

struct SearchBusStopView: View {
    
    @Environment (\.presentationMode) var presentationMode
    
//    @Environment(\.managedObjectContext) var managedObjectContext
//    
//    @FetchRequest(entity: Stop.entity(), sortDescriptors: []) var busStops: FetchedResults<Stop>
//    
    @State var searchTextNumberStop: String
    
    @State var isNavigation = false
    
    @State var showingAlertEmpty = false
    @State var showingMap = false
    @State var showingSearchLine = false
    @State var showingSearchLocation = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Form{
                    Section{
                        
                        HStack{
                            Spacer()
                            
                            Image(systemName: "paperplane.circle.fill")
                                .foregroundColor(Color.greenBus)
                                . font(.system(size: 50))
                                .onTapGesture {
                                    self.showingSearchLocation.toggle()
                                }
                            Spacer()
                            
                            Image(systemName: "map.circle.fill")
                                .foregroundColor(Color.greenBus)
                                . font(.system(size: 50))
                                .onTapGesture {
                                    self.showingMap.toggle()
                                }
                            Spacer()
                            
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(Color.greenBus)
                                . font(.system(size: 50))
                                .onTapGesture {
                                    self.showingSearchLine.toggle()
                                }
                            Spacer()
                        }
                    }
                    Section{
                        VStack{
                            HStack{
                                TextField("Código de parada", text: $searchTextNumberStop)
                                    .keyboardType(.numberPad)
                                    .disableAutocorrection(true)
                                NavigationLink("", destination: DetailStopView(nameStop: "", numberStop: searchTextNumberStop, tariffZoneStop: "", linesStop: "", aliasStop: "", featureStop: false), isActive: $isNavigation)
                                    .hidden()
                                withAnimation{
                                        Text("Buscar")
                                            .foregroundColor(.white)
                                            .padding(5)
                                            .background(Color.greenBus)
                                            .cornerRadius(7)
                                            .onTapGesture {
                                                if searchTextNumberStop.isEmpty{
                                                    self.showingAlertEmpty.toggle()
                                                }else{
                                                    self.isNavigation.toggle()
                                                }
                                            }
                                            .alert("Introduce número de parada", isPresented: $showingAlertEmpty) {
                                                Button("OK", role: .cancel){}
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Label("Atrás", systemImage: "chevron.backward")
                        .font(.subheadline)
                        .foregroundColor(Color.greenBus)
                        .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Interurbanos")
                        .foregroundColor(Color.greenBus)
                }
            }
            .sheet(isPresented: $showingMap) {
                MapView(locations: [Location(nameStop: "", numberStop: "", tariffZoneStop: "", linesStop: "", typeOfTransport: "", xGeometryStop: 0.0, yGeometryStop: 0.0)])
            }
            .sheet(isPresented: $showingSearchLine) {
                LinesView(searchLine: "", direction: "")
            }
            .sheet(isPresented: $showingSearchLocation) {
                NameLocationView(nameLocation: "", nameLocationReal: "")
            }
        }
        .navigationBarHidden(true)
    }
}

struct SearchBusStopView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBusStopView(searchTextNumberStop: "12345")
    }
}
