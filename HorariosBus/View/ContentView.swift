//
//  ContentView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 25/4/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var busStops: FetchedResults<BusStop>
    
    @State private var searchText: String = ""
    
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Button{
                        
//                        let busStop = BusStop(context: moc)
//                        busStop.name = "AV.Lazarejo-Santolina"
//                        busStop.number = 15213
//
//                        try? moc.save()
                    }label: {
                        Image(systemName: "plus")
                    }
                }
                Section {
                    List(busStops) { busStop in
                        HStack{
                            Image(systemName: "bus.fill")
                                .padding(5)
                                .foregroundColor(.green)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                                        .stroke(.gray, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading, spacing: 2){
                                Text(busStop.name ?? "Desconocido")
                                    .font(.system(.callout, design: .rounded))
                                Text(String(busStop.number))
                                    .font(.system(size: 12, weight: .light, design: .rounded))
                            }
                        }
                        
                    }
                }
            }
            .navigationTitle("Autobuses")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Número de parada")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
