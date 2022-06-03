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
    
    @State var name: String
    @State var numberCode: String
    @State var zone: String
    @State var lines: String
    @State var alias: String
    @State var feature: Bool
    
    @State private var showAlertAlias = false
    
    var stopId: NSManagedObjectID?
    let viewModel = AddStopViewModel()
    
    var body: some View {
        NavigationView{
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
                        Text(name)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        Text(numberCode)
                            .font(.system(.headline, design: .rounded))
                        HStack{
                            Text("Zona tarifaria: \(zone)")
                                .font(.system(.subheadline, design: .rounded))
                        }
                    }.padding(.leading, 5)
                }
                
                .alert("Guardar como Favorita", isPresented: $showAlertAlias, actions: {
                    Button("Guardar"){}
                    Button("Cancelar", role: .cancel){
                        alias = ""
                    }
                }, message: {
                    VStack{
                        Text("Dale un nombre a tu parada")
                        TextField("", text: $alias)
                    }
                })
                
                .padding()
                .background(.green.opacity(0.4))
                .cornerRadius(10)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Atrás"){
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button{
                        //TODO: recargar la vista
                    }label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    Button{
                        self.feature.toggle()
                        if feature {
                            alertTextField(title: "Guardar como favorita", message: "Escribe un nombre para esta parada", hintText: name, primaryTitle: "Guardar", secondaryTitle: "Cancelar") { text in
                               
                                let values = StopValues(name: name, number: numberCode, tariffZone: zone, lines: lines, alias: text, feature: feature)
                                
                                viewModel.saveStop(stopId: stopId, with: values, in: managedObjectContext)
                                } secondaryAction: {
                                    print("cancel")
                                }
                        }
                        if !feature {
                            //
                        }
                        
                        
                        
                    }label: {
                        Image(systemName: feature ? "heart.fill" : "heart")
                    }

                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct DetailStopView_Previews: PreviewProvider {
    static var previews: some View {
        DetailStopView(name: "Av Lazarejo - C/Santolina", numberCode: "12345", zone: "B2", lines: "628, L1", alias: "", feature: false)
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
