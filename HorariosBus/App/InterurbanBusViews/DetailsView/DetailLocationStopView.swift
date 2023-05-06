//
//  DetailLocationStopView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 15/6/22.
//

import SwiftUI

struct DetailLocationStopView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var stopsByNumberLine = [String:[StopByLineValues]] ()
    @State var numbersLines: [String] = []
    @State var nameLocation: String
    @State var nameLocationReal: String
    
    @State var searchNumberLine = ""
    @State var choosceDirection = ""
    
    @State var isCharged = false
    @State var showingAlert = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Form{
                    Section{
                        TextField("Burcar por dirección de línea", text: $searchNumberLine)
                        VStack(alignment: .leading){
                            Text("Escoge un sentido:")
                            HStack{
                                Spacer()
                                Text("Madrid")
                                    .padding(9)
                                    .background(.green)
                                    .cornerRadius(5)
                                    .onTapGesture{
                                        self.choosceDirection = "1"
                                    }
                                Text(nameLocationReal)
                                    .padding(9)
                                    .background(.green)
                                    .cornerRadius(5)
                                    .onTapGesture{
                                        self.choosceDirection = "2"
                                    }
                                Spacer()
                            }
                        }
                    }
                    
                    ForEach(numbersLines.sorted(by: < ).filter{ line in
                        return searchNumberLine.isEmpty ? true : line.contains(searchNumberLine)
                    }, id:\.self) { line in
                        Section{
                            List{
                                ForEach(stopsByNumberLine[line]!.filter{ direction in
                                    return choosceDirection.isEmpty ? true : direction.directionLine == choosceDirection
                                }.sorted(by: { lineA, lineB in
                                    return lineA.positionStopLine > lineB.positionStopLine
                                }), id: \.self) { stop in
                                    HStack{
                                        VStack{
                                            Text(stop.nameStop)
                                                .font(.system(size: 19, weight: .bold, design: .rounded))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            HStack{
                                                Image(systemName: "bus.fill")
                                                    .foregroundColor(.green)
                                                    .offset(x: 0, y: 2)
                                                Text(stop.adressStop)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    
                                            }
                                        }
                                        Spacer()
                                        Text(stop.numberStop)
                                            .font(.system(size: 19, weight: .bold, design: .rounded))
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .refreshable {
                                isCharged.toggle()
                                chargedNetworking()
                            }
                        } header: {
                            Text(line)
                                .padding(5)
                                .background(.green)
                                .cornerRadius(5)
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
                        .foregroundColor(.green)
                        .padding(2)
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
                ToolbarItem(placement: .principal) {
                    Text(nameLocationReal)
                        .padding(2)
                        .font(.system(.title2, design: .rounded))
                        .foregroundColor(.green)
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
            .alert("Error al cargar las paradas", isPresented: $showingAlert) {
                Button("OK", role: .cancel){}
            }
            .onAppear{
                self.isCharged.toggle()
                chargedNetworking()
            }
        }
        .navigationBarHidden(true)
    }
    
    func chargedNetworking() {
        NetworkingProvider.shared.getStopByLocation(nameLocation: nameLocation) { allStopsResponse in
            self.isCharged.toggle()
            
            for feature in allStopsResponse.features{
                guard let attribute = feature.attributes else{ return }
                if stopsByNumberLine.keys.contains(attribute.numberLine ?? "") == false && attribute.directionLine == "2"{
                    stopsByNumberLine[attribute.numberLine ?? ""] = [StopByLineValues(numberLine: attribute.numberLine ?? "", directionLine: attribute.directionLine ?? "", positionStopLine: attribute.positionStopLine ?? -1, nameStop: attribute.nameStop ?? "", adressStop: attribute.adressStop ?? "", tariffZoneStop: attribute.tariffZoneStop ?? "", numberStop: attribute.numberStop ?? "", locationStop: attribute.locationStop ?? "")]
                    numbersLines.append(attribute.numberLine ?? "")
                }
                else if stopsByNumberLine.keys.contains(attribute.numberLine ?? "") == true && stopsByNumberLine[attribute.numberLine ?? ""]!.contains(StopByLineValues(numberLine: attribute.numberLine ?? "", directionLine: attribute.directionLine ?? "", positionStopLine: attribute.positionStopLine ?? -1, nameStop: attribute.nameStop ?? "", adressStop: attribute.adressStop ?? "", tariffZoneStop: attribute.tariffZoneStop ?? "", numberStop: attribute.numberStop ?? "", locationStop: attribute.locationStop ?? "")) == false {
                    stopsByNumberLine[attribute.numberLine ?? ""]!.append(StopByLineValues(numberLine: attribute.numberLine ?? "", directionLine: attribute.directionLine ?? "", positionStopLine: attribute.positionStopLine ?? -1, nameStop: attribute.nameStop ?? "", adressStop: attribute.adressStop ?? "", tariffZoneStop: attribute.tariffZoneStop ?? "", numberStop: attribute.numberStop ?? "", locationStop: attribute.locationStop ?? ""))
                }
            }
        } failure: { error in
            self.isCharged.toggle()
            self.showingAlert.toggle()
        }
    }
}

struct DetailLocationStopView_Previews: PreviewProvider {
    static var previews: some View {
        DetailLocationStopView(nameLocation: "ROZAS+DE+MADRID,+LAS", nameLocationReal: "Las Rozas de Madrid")
    }
}
