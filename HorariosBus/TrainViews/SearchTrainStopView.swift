//
//  SearchTrainStopView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 20/6/22.
//

import SwiftUI

struct SearchTrainStopView: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    @State var searchTextNameStop = ""
    @State var allStops: [StopValues] = []
    @State var numberStop: String = ""
    
    @State var showingAlertEmpty = false
    @State var showingAlertError = false
    
    @State var showingImageMapTrainView = false
    @State var showingMapTrainView = false
    
    
    @State var isNavigation = false
    @State var isCharged = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Form{
                    Section{
                        HStack{
                            Spacer()
                            
                            ZStack{
                                Image(systemName: "paperplane.circle.fill")
                                    .foregroundColor(Color.redTrain)
                                    . font(.system(size: 50))
                                    .onTapGesture {
                                        self.showingImageMapTrainView.toggle()
                                    }
                                NavigationLink("", destination: ImageMapsView(), isActive: $showingImageMapTrainView)
                                    .hidden()
                            }
                            
                            Spacer()
                            ZStack{
                                Image(systemName: "map.circle.fill")
                                    .foregroundColor(Color.redTrain)
                                    . font(.system(size: 50))
                                    .onTapGesture {
                                        self.showingMapTrainView.toggle()
                                    }
                                NavigationLink("", destination: MapTrainView(), isActive: $showingMapTrainView)
                                    .hidden()
                            }
                            
                            Spacer()
                        }
                    }
                    Section{
                        VStack{
                            TextField("Escribe nombre de la parada", text: $searchTextNameStop)
                                .keyboardType(.asciiCapable)
                                .disableAutocorrection(true)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                                        .stroke(.gray, lineWidth: 1)
                                )
                            
                            List{
                                ForEach(allStops
                                    .sorted { lineA, lineB in
                                        return lineA.name < lineB.name }
                                    .filter { line in
                                        return searchTextNameStop.isEmpty ? true : line.name.contains(searchTextNameStop) }
                                    .filter{ line in
                                    return line.lines.isEmpty == false }, id: \.self) { stop in
                                    ZStack{
                                        HStack{
                                            Image(systemName: "tram.fill")
                                                .padding(8)
                                                .frame(width: 30, height: 30)
                                                .background(Color.redTrain)
                                                .cornerRadius(5)
                                            VStack(alignment: .leading){
                                                Text(stop.name)
                                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                                
                                                WrapView(items: stop.lines.replacingOccurrences(of: ",", with: "").components(separatedBy: " "))
                                            }
                                            .padding(5)
                                            Spacer()
                                        }.onTapGesture{
                                            self.isNavigation.toggle()
                                            numberStop = stop.number
                                        }
                                        NavigationLink("", destination: DetailStopTrainView(nameStop: "", numberStop: numberStop,  tariffZoneStop: "", linesStop: "", aliasStop: "", featureStop: false, typeTransport: ""), isActive: $isNavigation)
                                            .hidden()
                                    }
                                }
                            }.refreshable {
                                self.isCharged.toggle()
                                chargedNetworking()
                            }
                        }
                    }
                }
                
                if isCharged {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Label("Atrás", systemImage: "chevron.backward")
                        .font(.subheadline)
                        .foregroundColor(Color.redTrain)
                        .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Cercanias")
                        .foregroundColor(Color.redTrain)
                        .font(.system(.title2, design: .rounded))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        self.isCharged.toggle()
                        chargedNetworking()
                        
                    }label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(Color.redTrain)
                    }
                }
            }
            .alert("Error al cargar las paradas", isPresented: $showingAlertError) {
                Button("OK", role: .cancel){}
            }
            .onAppear{
                isCharged.toggle()
                chargedNetworking()
            }
        }
        .navigationBarHidden(true)
    }
    
    func chargedNetworking() {
        NetworkingProvider.shared.getAllStopsTrain { allStopsTrainResponse in
            self.isCharged.toggle()
            for attibutes in allStopsTrainResponse.features {
                if allStops.contains(StopValues(name: attibutes.nameStop, number: attibutes.numberStop, tariffZone: attibutes.tariffZoneStop, lines: attibutes.linesStop, alias: "", feature: false, typeTransport: "")) == false{
                    allStops.append(StopValues(name: attibutes.nameStop, number: attibutes.numberStop, tariffZone: attibutes.tariffZoneStop, lines: attibutes.linesStop, alias: "", feature: false, typeTransport: ""))
                }
            }
        } failure: { error in
            self.isCharged.toggle()
            self.showingAlertError.toggle()
        }

    }
}

struct SearchTrainStopView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTrainStopView()
    }
}
