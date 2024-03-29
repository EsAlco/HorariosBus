//
//  DetailLineStopsView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 9/6/22.
//

import SwiftUI

struct DetailLineStopsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var searchNameStop: String = ""
    @State var stopsByLine: [StopByLineValues] = []
    @State var directionLine: String
    @State var numberLine: String
    @State var numberStop: String
    @State var nameDierection: String
    
    @State var isCharged = false
    @State var showingAlertError = false
    @State var showDetailStop = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Form{
                    Section{
                        TextField("Escribe el nombre de la parada", text: $searchNameStop)
                    }
                    
                    Section{
                        List(stopsByLine
                            .sorted { stopA, stopB in
                            return stopA.positionStopLine < stopB.positionStopLine
                            }.filter { stop in
                                return searchNameStop.isEmpty ? true : stop.nameStop.contains(searchNameStop)
                            }, id: \.self) { stop in
                            HStack{
                                Text(stop.numberLine)
                                    .padding(7)
                                    .background(.green)
                                    .cornerRadius(8)
                                Text(stop.nameStop)
                            }
                            .onTapGesture {
                                self.showDetailStop.toggle()
                                numberStop = stop.numberStop
                            }
                        }
                    }
                }
                .alert("Error al cargar la parada", isPresented: $showingAlertError) {
                    Button("OK", role: .cancel){}
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Label("Atrás", systemImage: "chevron.backward")
                            .font(.subheadline)
                            .padding(2)
                            .foregroundColor(.green)
                            .onTapGesture {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    }
                    ToolbarItem(placement: .principal) {
                        VStack{
                            Text(numberLine)
                                .font(.system(.title2, design: .rounded))
                                .foregroundColor(.green)
                            Text(nameDierection)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.green)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button{
                            self.isCharged.toggle()
                            chargedNetworking()
                            
                        }label: {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
                if isCharged {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                }
                NavigationLink("", destination: DetailStopView(nameStop: "", numberStop: numberStop, tariffZoneStop: "", linesStop: "", aliasStop: "", featureStop: false), isActive: $showDetailStop)
                    .hidden()
            }
        }
        .navigationBarHidden(true)
        .onAppear{
            self.isCharged.toggle()
            chargedNetworking()
        }
    }
    
    func chargedNetworking() {
        NetworkingProvider.shared.getStopByLine(numberLine: numberLine) { stopsByLineResponse in
            self.isCharged.toggle()
            for feature in stopsByLineResponse.features{
                guard let attributes = feature.attributes else{ return }
                if attributes.directionLine == directionLine && stopsByLine.contains(StopByLineValues(numberLine: (attributes.numberLine)!, directionLine: attributes.directionLine ?? "", positionStopLine: attributes.positionStopLine ?? 0, nameStop: (attributes.nameStop)!, adressStop: attributes.adressStop ?? "", tariffZoneStop: attributes.tariffZoneStop ?? "", numberStop: (attributes.numberStop)!, locationStop: attributes.locationStop ?? "")) == false {
                    stopsByLine.append(StopByLineValues(numberLine: attributes.numberLine ?? "", directionLine: attributes.directionLine ?? "", positionStopLine: attributes.positionStopLine ?? -1, nameStop: attributes.nameStop ?? "", adressStop: attributes.adressStop ?? "", tariffZoneStop: attributes.tariffZoneStop ?? "", numberStop: attributes.numberStop ?? "", locationStop: attributes.locationStop ?? ""))
                }
            }
        } failure: { error in
            self.isCharged.toggle()
            self.showingAlertError.toggle()
        }
    }
}

struct DetailLineStopsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLineStopsView(directionLine: "2", numberLine: "628", numberStop: "11828", nameDierection: "El Cantizal")
    }
}
