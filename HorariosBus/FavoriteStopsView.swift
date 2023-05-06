//
//  FavoriteStopsView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba on 5/5/23.
//

import SwiftUI

struct FavoriteStopsView: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Stop.entity(), sortDescriptors: []) var busStops: FetchedResults<Stop>
    
    @State private var isDetailStopView = false
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach (busStops) { busStop in
                        HStack{
                            CellStopView(
                                aliasStop: busStop.alias ?? "Desconocido",
                                numberStop: busStop.number ?? "",
                                typeTransport: busStop.typeTransport ?? "")
                            .onTapGesture {
                                self.isDetailStopView.toggle()
                            }
                            
                            if busStop.typeTransport == "Interurban" {
                                NavigationLink("", destination: DetailStopView(
                                                nameStop: busStop.name ?? "",
                                                numberStop: busStop.number ?? "",
                                                tariffZoneStop: busStop.tariffZone ?? "",
                                                linesStop: busStop.lines ?? "",
                                                aliasStop: busStop.alias ?? "",
                                                featureStop: busStop.feature),
                                           isActive: $isDetailStopView)
                                    .hidden()
                            }
                            if busStop.typeTransport == "Train"{
                                NavigationLink("", destination: DetailStopTrainView(
                                                nameStop: busStop.name ?? "",
                                                numberStop: busStop.number ?? "",
                                                tariffZoneStop: busStop.tariffZone ?? "",
                                                linesStop: busStop.lines ?? "",
                                                aliasStop: busStop.alias ?? "",
                                                featureStop: busStop.feature,
                                                typeTransport: busStop.typeTransport ?? ""),
                                           isActive: $isDetailStopView)
                                    .hidden()
                            }


                        }
                    }.onDelete(perform: removeBusStops)
                }
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Label("Atrás", systemImage: "chevron.backward")
                        .font(.subheadline)
                        .foregroundColor(.yellow)
                        .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Paradas favoritas")
                        .foregroundColor(.yellow)
                        .underline()
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Número de parada")
        .navigationBarHidden(true)

    }
    
    func removeBusStops(at offsets: IndexSet) {
        for index in offsets {
            let busStop = busStops[index]
            managedObjectContext.delete(busStop)
        }
        PersistenceController.shared.save()
    }
}

struct FavoriteStopsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteStopsView()
    }
}
