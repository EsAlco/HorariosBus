//
//  ContentView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 25/4/22.
//


 import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Stop.entity(), sortDescriptors: []) var busStops: FetchedResults<Stop>
    
    @State private var searchText: String = ""
    @State var isInterBus = false
    @State private var isDetailView = false
    
    
    @State var showingAlert = false
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    HStack{
    
                        Image(systemName: "bus.fill")
                            .padding(14)
                            .background(.green)
                            .cornerRadius(25)
                            .onTapGesture {
                                self.isInterBus.toggle()
                            }
                        NavigationLink("", destination: SearchBusStopView(searchTextNumberStop: ""), isActive: $isInterBus)
                            .hidden()
                    }
                }
                Section {
                    List{
                        ForEach (busStops) { busStop in
                            HStack{
                                CellStopView(
                                    alias: busStop.alias ?? "Desconocido",
                                    numberStop: busStop.number ?? "")
                                .onTapGesture {
                                    self.isDetailView.toggle()
                                }
                                NavigationLink("", destination: DetailStopView(
                                                nameStop: busStop.name ?? "",
                                                numberCode: busStop.number ?? "",
                                                zone: busStop.tariffZone ?? "",
                                                lines: busStop.lines ?? "",
                                                alias: busStop.alias ?? "",
                                                feature: busStop.feature),
                                           isActive: $isDetailView)
                                    .hidden()
                            }
                        }.onDelete(perform: removeBusStops)
                    }
                }
            }
            .navigationTitle("Autobuses")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Número de parada")
        }
    }
    
    func removeBusStops(at offsets: IndexSet) {
        for index in offsets {
            let busStop = busStops[index]
            managedObjectContext.delete(busStop)
        }
        PersistenceController.shared.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
