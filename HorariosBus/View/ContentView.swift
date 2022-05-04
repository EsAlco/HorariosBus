//
//  ContentView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 25/4/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: BusStop.entity(), sortDescriptors: []) var busStops: FetchedResults<BusStop>
    
    @State private var searchText: String = ""
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    HStack{
                        /*
                        Image(systemName: "bus.fill")
                            .padding(14)
                            .background(.green)
                            .cornerRadius(25)
                            .onTapGesture {
                                
                            }*/
                        NavigationLink(destination: SearchBusStopView(searchNumberStop: 0, searchTextNumberStop: "Av")) {
                            SelectorView(image: "bus.fill", color: .green)
                            // TODO: guardar los datos
                        }
                        /*
                        NavigationLink(destination: SearchBusStopView(searchNumberStop: 0, searchTextNumberStop: "Av")) {
                            SelectorView(image: "bus.fill", color: .red)
                        }*/
                    }
                }
                Section {
                    List{
                        ForEach (busStops) { busStop in
                        CellStopView(
                            nameBus: busStop.name ?? "Desconocido",
                            numberBus: Int(busStop.number))
                        
                        }.onDelete(perform: removeBusStops)
                    }
                }
            }
            .navigationTitle("Autobuses")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add"){
                        let busStop = BusStop(context: managedObjectContext)
                        
                        busStop.name = "Av Lazarejo / Santolina"
                        busStop.number = 12345
                        
                        PersistenceController.shared.save()
                    }
                }
            }
            
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
