//
//  DetailStopView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 2/6/22.
//

import SwiftUI
import CoreData

struct DetailStopView: View {
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @Environment (\.presentationMode) var presentationMode
    
    @State var nameStop: String
    @State var numberStop: String
    @State var tariffZoneStop: String
    @State var linesStop: String
    @State var aliasStop: String
    @State var featureStop: Bool
    
    @State private var showDeleteFeature = false
    @State private var showingAlert = false
    @State private var isCharged = false
    
    var stopId: NSManagedObjectID?
    let viewModel = AddStopViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    HStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.green)
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "bus.fill")
                                    .scaleEffect(2)
                            )
                        
                        VStack(alignment: .leading){
                            Text(nameStop)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            Text(numberStop)
                                .font(.system(.headline, design: .rounded))
                            HStack{
                                Text("Zona tarifaria: \(tariffZoneStop)")
                                    .font(.system(.subheadline, design: .rounded))
                            }
                        }.padding(.leading, 5)
                    }
                    .padding()
                    .background(.green.opacity(0.4))
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    List{
                        ForEach (linesStop.replacingOccurrences(of: ",", with: "").components(separatedBy: " "), id:\.self) { line in
                            Text(line)
                        }
                    }.refreshable {
                        NetworkingProvider.shared.getStop(numberStop: numberStop) { stopResponse in
                            for attributes in stopResponse.features{
                                nameStop = attributes.nameStop
                                numberStop = attributes.numberStop
                                tariffZoneStop = attributes.tariffZoneStop
                                linesStop = attributes.linesStop
                            }
                                        
                        } failure: { error in
                            self.showingAlert.toggle()
                        }
                    }
                }
                if isCharged {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                }
            }
            .alert("Error al cargar la parada", isPresented: $showingAlert) {
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
                    Button("Atrás"){
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button{
                        self.isCharged.toggle()
                        NetworkingProvider.shared.getStop(numberStop: numberStop) { stopResponse in
                            self.isCharged.toggle()
                            for attributes in stopResponse.features{
                                nameStop = attributes.nameStop
                                numberStop = attributes.numberStop
                                tariffZoneStop = attributes.tariffZoneStop
                                linesStop = attributes.linesStop
                            }
                                        
                        } failure: { error in
                            self.isCharged.toggle()
                            self.showingAlert.toggle()
                        }                    }label: {
                        Image(systemName: "arrow.clockwise")
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
                    }
                }
            }
        }
        .navigationBarHidden(true)
        
        .onAppear{
            self.isCharged.toggle()
            NetworkingProvider.shared.getStop(numberStop: numberStop) { stopResponse in
                self.isCharged.toggle()
                for attributes in stopResponse.features{
                    nameStop = attributes.nameStop
                    numberStop = attributes.numberStop
                    tariffZoneStop = attributes.tariffZoneStop
                    linesStop = attributes.linesStop
                }
                            
            } failure: { error in
                self.isCharged.toggle()
                self.showingAlert.toggle()
            }
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

struct DetailStopView_Previews: PreviewProvider {
    static var previews: some View {
        DetailStopView(nameStop: "Av Lazarejo - C/Santolina", numberStop: "12345", tariffZoneStop: "B2", linesStop: "628, L1", aliasStop: "", featureStop: false)
    }
}


extension View{
    
    
    // MARK: Alert's TextField
    func alertTextField(title: String, message: String, hintText: String, primaryTitle: String, secondaryTitle: String, primaryAction: @escaping (String)->(), secondaryAction: @escaping ()->()){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = hintText
        }
        
        alert.addAction(.init(title: secondaryTitle, style: .cancel, handler: { _ in
            secondaryAction()
        }))
        
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            if let text = alert.textFields?[0].text {
                primaryAction(text)
            } else {
                primaryAction("")
            }
        }))
        
        // MARK: Presenting alert
        rootController().present(alert, animated: true, completion: nil)
    }
    
    // MARK: Root View Controller
    func rootController()->UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}
