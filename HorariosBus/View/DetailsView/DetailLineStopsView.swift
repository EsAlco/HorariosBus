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
    
    @State var isCharged = false
    @State var showingAlertError = false
    
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
                            .onTapGesture {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
                if isCharged {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear{
            self.isCharged.toggle()
            
            NetworkingProvider.shared.getStopByLine(numberLine: numberLine) { stopsByLineResponse in
                self.isCharged.toggle()
                for attributes in stopsByLineResponse.features{
                    if attributes.directionLine == directionLine && stopsByLine.contains(StopByLineValues(numberLine: attributes.numberLine, directionLine: attributes.directionLine, positionStopLine: attributes.positionStopLine, nameStop: attributes.nameStop, adressStop: attributes.adressStop, tariffZoneStop: attributes.tariffZoneStop ?? "", numberStop: attributes.numberStop)) == false {
                        stopsByLine.append(StopByLineValues(numberLine: attributes.numberLine, directionLine: attributes.directionLine, positionStopLine: attributes.positionStopLine, nameStop: attributes.nameStop, adressStop: attributes.adressStop, tariffZoneStop: attributes.tariffZoneStop ?? "", numberStop: attributes.numberStop))
                    }
                }
            } failure: { error in
                self.isCharged.toggle()
                self.showingAlertError.toggle()
            }
        }
    }
}

struct DetailLineStopsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLineStopsView(directionLine: "2", numberLine: "628")
    }
}
