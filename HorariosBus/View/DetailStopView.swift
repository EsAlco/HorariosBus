//
//  DetailStopView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 2/6/22.
//

import SwiftUI

struct DetailStopView: View {
    
    @State var name: String
    @State var numberCode: String
    @State var zone: String
    @State var lines: String
    
    var body: some View {
        HStack{
            Image(systemName: "bus.fill")
            VStack{
                Text(name)
                Text(numberCode)
                HStack{
                    Text(zone)
                    Text(lines)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct DetailStopView_Previews: PreviewProvider {
    static var previews: some View {
        DetailStopView(name: "Av Lazarejo - C/Santolina", numberCode: "12345", zone: "B2", lines: "628, L1")
    }
}
