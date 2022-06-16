//
//  LinesView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 9/6/22.
//

import SwiftUI

struct LinesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var searchLine = ""
    @State var isCharged = false
    
    @State var stopsByLines = [String:[String:String]] ()
    @State var listStops = [StopsByLineSimplyValues]()
    @State var direction: String
    @State var lineNumber: String = ""
    @State var nameStop1: String = ""
    @State var nameStop2: String = ""
    
    @State var showingAlertError = false
    @State var showingSelectedDirection = false
    
    @State var showDetailLineStops = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Form{
                    Section{
                        TextField("Buscar por número de linea", text: $searchLine)
                    }
                    Section{
                        List{
                            ForEach(listStops
                                .sorted { lineA, lineB in
                                    return lineA.numberLine < lineB.numberLine
                                }.filter { stop in
                                    return searchLine.isEmpty ? true : stop.numberLine.contains(searchLine)
                                }, id: \.self) { line in
                                    
                                HStack{
                                    Text(line.numberLine)
                                        .padding(9)
                                        .font(.system(.title2, design: .rounded))
                                        .frame(width: 80, height: 40)
                                        . background(.green)
                                        .cornerRadius(10)
                                    
                                    Text(line.nameStop1)
                                        .font(.system(.body, design: .rounded))
                                        .frame(width: 100, height: 40)

                                    Image(systemName: "repeat")

                                    Text(line.nameStop2)
                                        .font(.system(.body, design: .rounded))
                                        .frame(width: 100, height: 40)
                                }
                                .onTapGesture {
                                    self.showingSelectedDirection.toggle()
                                    lineNumber = line.numberLine
                                    nameStop1 = line.nameStop1
                                    nameStop2 = line.nameStop2
                                }
                            }
                        }
                    }
                }
                .alert("Error al cargar la parada", isPresented: $showingAlertError) {
                    Button("OK", role: .cancel){}
                }

                if isCharged {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                }
                
                NavigationLink("", destination: DetailLineStopsView(directionLine: direction, numberLine: lineNumber, numberStop: ""), isActive: $showDetailLineStops)
                    .hidden()
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
                ToolbarItem(placement: .principal) {
                    Text("Buscar por línea")
                        .padding(2)
                        .font(.system(.title2, design: .rounded))
                }
            }
            .confirmationDialog("Dirección", isPresented: $showingSelectedDirection) {
                Button {
                    direction = "1"
                    self.showDetailLineStops.toggle()
                } label: {
                    Text(nameStop1)
                }
                Button {
                    direction = "2"
                    self.showDetailLineStops.toggle()
                } label: {
                    Text(nameStop2)
                }
            } message: {
                Text(lineNumber)
            }
        }
        .onAppear{
            self.isCharged.toggle()
            chargedNetworking()
        }
        .navigationBarHidden(true)
    }

    func chargedNetworking() {
        NetworkingProvider.shared.getAllStopsByLine { allStopsByLineResponse in
            self.isCharged.toggle()
            
            for attributes in allStopsByLineResponse.features{
                if stopsByLines.keys.contains(attributes.numberLine) == false && attributes.positionStopLine == 1 {
                    if attributes.directionLine == "1" {
                        stopsByLines[attributes.numberLine] = ["Line": attributes.numberLine, "Name1": attributes.nameStop, "Name2": ""]
                    }
                    else if attributes.directionLine == "2" {
                        stopsByLines[attributes.numberLine] = ["Line": attributes.numberLine, "Name1": "", "Name2": attributes.nameStop]
                    }
                }
                else if stopsByLines.keys.contains(attributes.numberLine) == true && attributes.positionStopLine == 1{
                    if attributes.directionLine == "1" {
                        stopsByLines[attributes.numberLine]!["Name1"] = attributes.nameStop
                    }
                    else if attributes.directionLine == "2" {
                        stopsByLines[attributes.numberLine]!["Name2"] = attributes.nameStop
                    }
                }
            }
            for line in stopsByLines{
                let principalStopsByLine = line.value
                listStops.append(StopsByLineSimplyValues(numberLine: line.value["Line"] ?? "", nameStop1: principalStopsByLine["Name1"] ?? "", nameStop2: principalStopsByLine["Name2"] ?? ""))
            }
        } failure: { error in
            self.isCharged.toggle()
            self.showingAlertError.toggle()
        }
    }

}

struct LinesView_Previews: PreviewProvider {
    static var previews: some View {
        LinesView(searchLine: "", direction: "1")
    }
}
