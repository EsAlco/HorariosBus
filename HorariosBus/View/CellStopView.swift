//
//  CellStopView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 26/4/22.
//

import SwiftUI

struct CellStopView: View {
    
    @State var nameBus: String
    @State var numberBus: Int
    
    var body: some View {
        HStack{
            Image(systemName: "bus.fill")
                .padding(5)
                .foregroundColor(.green)
                .overlay(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(.gray, lineWidth: 1)
                )
            
            VStack(alignment: .leading, spacing: 2){
                Text(nameBus)
                    .font(.system(.callout, design: .rounded))
                Text(String(numberBus))
                    .font(.system(size: 12, weight: .light, design: .rounded))
            }
        }
    }
}

struct CellStopView_Previews: PreviewProvider {
    static var previews: some View {
        CellStopView(nameBus: "Av. Lazarejo/Santolina", numberBus: 15213)
    }
}