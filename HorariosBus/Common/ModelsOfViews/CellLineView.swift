//
//  CellLineView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 9/6/22.
//

import SwiftUI

struct CellLineView: View {
    
    @State var nameLineDirection1: String
    @State var nameLineDirection2: String
    @State var numberLine: String
    @State var direction: String
    
    @State var showingSelectedDirection = false
    @State var showDetailLineStops = false
    
    var body: some View {
        HStack{
            Text(numberLine)
                .padding(9)
                .font(.system(.title2, design: .rounded))
                .frame(width: 80, height: 40)
                . background(.green)
                .cornerRadius(10)
            Text(nameLineDirection1)
                .font(.system(.body, design: .rounded))
                .frame(width: 100, height: 40)
            Image(systemName: "repeat")
            Text(nameLineDirection2)
                .font(.system(.body, design: .rounded))
                .frame(width: 100, height: 40)
        }
        .onTapGesture {
            self.showingSelectedDirection.toggle()
        }
        .actionSheet(isPresented: $showingSelectedDirection) {
            ActionSheet(
                title: Text("Dirección"),
                message: Text(numberLine),
                buttons: [
                    .default(Text(nameLineDirection1), action: {
                        direction = "1"
                        self.showDetailLineStops.toggle()
                    }),
                    .default(Text(nameLineDirection2), action: {
                        direction = "2"
                        self.showDetailLineStops.toggle()
                    }),
                    .cancel()
                ])
        }
    }
}

struct CellLineView_Previews: PreviewProvider {
    static var previews: some View {
        CellLineView(nameLineDirection1: "Madrid", nameLineDirection2: "El Cantizal", numberLine: "628", direction: "1")
    }
}
