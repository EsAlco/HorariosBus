//
//  DetailStopTrainView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 20/6/22.
//

import SwiftUI
import CoreData

struct DetailStopTrainView: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @State var nameStop: String
    @State var numberStop: String
    @State var tariffZoneStop: String
    @State var linesStop: String
    @State var aliasStop: String
    @State var featureStop: Bool
    
    @State var isCharged = false
    @State var showingAlertError = false
    @State private var showDeleteFeature = false
    
    var stopId: NSManagedObjectID?
    let viewModel = AddStopViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    HStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.redTrain)
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "tram.fill")
                                    .scaleEffect(2)
                            )
                        VStack(alignment: .leading){
                            Text(nameStop)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .minimumScaleFactor(0.01)
                            HStack{
                                Text("Zona tarifaria: \(tariffZoneStop)")
                                    .font(.system(.subheadline, design: .rounded))
                            }
                        }
                        .padding(.leading, 5)
                    }
                    .padding()
                    .background(Color.redTrain.opacity(0.4))
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    List{
                        ForEach (linesStop.replacingOccurrences(of: ",", with: "").components(separatedBy: " "), id:\.self) { line in
                            Text(line)
                                .textCase(.uppercase)
                                .padding(5)
                                .frame(width: 60, height: 30)
                                .background{
                                    switch line {
                                    case "C-1":
                                        Color.C1
                                    case "C-2":
                                        Color.C2
                                    case "C-3":
                                        Color.C3
                                    case "C-3A", "C-3B":
                                        Color.C3AB
                                    case "C-4":
                                        Color.C4
                                    case "C-5":
                                        Color.C5
                                    case "C-7":
                                        Color.C7
                                    case "C-8":
                                        Color.C8
                                    case "C-9":
                                        Color.C9
                                    case "C-10":
                                        Color.C10
                                    default:
                                        Color.greenBus
                                    }}
                                .cornerRadius(9)
                        }
                    }.refreshable {
                        isCharged.toggle()
                        chargedNetworking()
                    }
                }
                if isCharged {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                }
            }
            .alert("Error al cargar la parada", isPresented: $showingAlertError) {
                Button("OK", role: .cancel){}
            }
            .alert("Eliminar como favorita", isPresented: $showDeleteFeature, actions: {
                Button("Sí"){
                    self.featureStop = false
                    removeStops(predicate: numberStop)
                }
                Button("No", role: .cancel){}
            }, message: {
                Text("¿Seguro que quieres eliminar de favoritos esta parada?")
            })
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
                    Text(nameStop)
                        .foregroundColor(Color.redTrain)
                        .font(.system(.title2, design: .rounded))
                        .minimumScaleFactor(0.01)
                        .frame(width: 200)
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button{
                        self.isCharged.toggle()
                        chargedNetworking()
                        
                    }label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(Color.redTrain)
                    }
                    Button{
                        if !featureStop {
                            alertTextField(title: "Guardar como favorita", message: "Escribe un nombre para esta parada", hintText: nameStop, primaryTitle: "Guardar", secondaryTitle: "Cancelar") { text in
                                
                                    self.featureStop = true
                               
                                let values = StopValues(name: nameStop, number: numberStop, tariffZone: tariffZoneStop, lines: linesStop, alias: text == "" ? nameStop : text, feature: featureStop)
                                
                                viewModel.saveStop(stopId: stopId, with: values, in: managedObjectContext)
                                } secondaryAction: {}
                        }
                        if featureStop {
                            self.showDeleteFeature.toggle()
                        }
                    }label: {
                        Image(systemName: featureStop ? "heart.fill" : "heart")
                            .foregroundColor(Color.redTrain)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear{
            self.isCharged.toggle()
            chargedNetworking()
        }
    }
    
    func chargedNetworking() {
        NetworkingProvider.shared.getStopTrain(numberLine: numberStop) { stopTrainResponse in
            self.isCharged.toggle()
            
            for attributes in stopTrainResponse.features {
                nameStop = attributes.nameStop
                numberStop = attributes.numberStop
                tariffZoneStop = attributes.tariffZoneStop
                linesStop = attributes.linesStop
            }
        } failure: { error in
            self.isCharged.toggle()
            self.showingAlertError.toggle()
        }
    }
    
    func removeStops(predicate: String) {
    
        let fetchRequest: NSFetchRequest<Stop>
        fetchRequest = Stop.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "number == %@", predicate)
        fetchRequest.includesPropertyValues = false
        let context = managedObjectContext
        if let busStops = try? context.fetch(fetchRequest){
            for busStop in busStops {
                context.delete(busStop)
            }
        }
    
        PersistenceController.shared.save()
    }
}

struct DetailStopTrainView_Previews: PreviewProvider {
    static var previews: some View {
        DetailStopTrainView(nameStop: "Pinar de Las Rozas", numberStop: "55", tariffZoneStop: "B2", linesStop: "C-8, C-10", aliasStop: "", featureStop: false)
    }
}
