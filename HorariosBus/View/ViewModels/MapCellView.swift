//
//  MapCellView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 7/6/22.
//

import SwiftUI

struct MapCellView: View {
    
    @State var nameStop: String
    @State var numberStop: String
    @State var linesStop: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 250, height: 90)
            .foregroundColor(Color.gray)
            .overlay(
                HStack(alignment: .top){
                    Image(systemName: "bus.fill")
                        .padding(9)
                        .background(.green)
                        .cornerRadius(9)
                        .font(.title)
                        .padding()
                    VStack(alignment: .leading){
                        Text(nameStop)
                            .font(.system(.title3, design: .rounded))
                        Text(numberStop)
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.green)
                        Text(linesStop)
                            .font(.system(.caption, design: .rounded))
                            .padding(5)
                            .background(.green)
                            .cornerRadius(5)
                    }
                    Spacer()
                }.padding()
            )
    }
}

struct MapCellView_Previews: PreviewProvider {
    static var previews: some View {
        MapCellView(nameStop: "Satolina", numberStop: "11282", linesStop: "628")
    }
}
