//
//  SearchBusStopView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 25/4/22.
//

import SwiftUI

struct SearchBusStopView: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Stop.entity(), sortDescriptors: []) var busStops: FetchedResults<Stop>
    
    @State var searchTextNumberStop: String
    @State var isCharged = false
    @State var showingAlertEmpty = false
    @State var isNavigation = false
    @State var showingAlert = false
    
    @State var nameStop = ""
    @State var numberCodeStop = ""
    @State var zoneStop = ""
    @State var linesStop = ""
    
    var body: some View {
        NavigationView{
            ZStack{
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
                        VStack{
                            HStack{
                                TextField("Código de parada", text: $searchTextNumberStop)
                                    .keyboardType(.numberPad)
                                    .disableAutocorrection(true)
                                NavigationLink("", destination: DetailStopView(name: nameStop, numberCode: numberCodeStop, zone: zoneStop, lines: linesStop, alias: "", feature: false), isActive: $isNavigation)
                                    .hidden()
                                withAnimation{
                                        Text("Buscar")
                                            .foregroundColor(.white)
                                            .padding(5)
                                            .background(.green)
                                            .cornerRadius(7)
                                            .onTapGesture {
                                                if searchTextNumberStop.isEmpty{
                                                    self.showingAlertEmpty.toggle()
                                                }else{
                                                    self.isCharged.toggle()
                                                    NetworkingProvider.shared.getStop(numberStop: searchTextNumberStop) { stopResponse in
                                                        self.isCharged.toggle()
                                                        for attributes in stopResponse.features{
                                                            nameStop = attributes.name ?? ""
                                                            numberCodeStop = attributes.numberCode ?? ""
                                                            zoneStop = attributes.zone ?? ""
                                                            linesStop = attributes.lines ?? ""
                                                            
                                                        }
                                                        self.isNavigation.toggle()
                                                                    
                                                    } failure: { error in
                                                        self.isCharged.toggle()
                                                        self.showingAlert.toggle()
                                                    }
                                                }
                                            }
                                            .alert("Introduce número de parada", isPresented: $showingAlertEmpty) {
                                                Button("OK", role: .cancel){}
                                            }
                                            .alert("Error al cargar la parada", isPresented: $showingAlert) {
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
                if isCharged {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Atrás"){
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Interurbanos")
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct SearchBusStopView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBusStopView(searchTextNumberStop: "12345", nameStop: "", numberCodeStop: "", zoneStop: "", linesStop: "")
    }
}
