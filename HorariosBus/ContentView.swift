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
    
    @State private var isDetailStopView = false
    
    @State private var isShowingSideMenu = false
    
    @State var showingAlert = false
    
    
    var body: some View {
        NavigationView{
            ZStack{
                MapView(isMainView: true)
                
                SideMenuView(isShowingSideMenu: $isShowingSideMenu)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.isShowingSideMenu.toggle()
                    } label: {
                        if !isShowingSideMenu {
                            Image(systemName: "list.bullet")
                                .frame(width: 20, height: 20, alignment: .center)
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.backgrounColor)
                                .cornerRadius(20)
                        }
                    }
                }
            }
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
