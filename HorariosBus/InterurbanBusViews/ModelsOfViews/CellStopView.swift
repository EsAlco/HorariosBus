//
//  CellStopView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 26/4/22.
//

import SwiftUI

struct CellStopView: View {
    
    @State var aliasStop: String
    @State var numberStop: String
    @State var typeTransport: String
    
    var body: some View {
        HStack{
            Image(systemName: typeTransport == "Interurban" ? "bus.fill" : typeTransport == "Train" ? "tram.fill" : "questionmark.circle")
                .padding(5)
                .foregroundColor(typeTransport == "Interurban" ? Color.greenBus : typeTransport == "Train" ? Color.redTrain : Color.yellow)
                .frame(width: 50, height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(.gray, lineWidth: 1)
                )
            
            VStack(alignment: .leading, spacing: 2){
                Text(aliasStop)
                    .font(.system(.callout, design: .rounded))
                Text(numberStop)
                    .font(.system(size: 12, weight: .light, design: .rounded))
                    .minimumScaleFactor(0.01)
                Text(typeTransport)
            }
        }
    }
}

struct CellStopView_Previews: PreviewProvider {
    static var previews: some View {
        CellStopView(aliasStop: "Av. Lazarejo/Santolina", numberStop: "15213", typeTransport: "Interurban")
    }
}
