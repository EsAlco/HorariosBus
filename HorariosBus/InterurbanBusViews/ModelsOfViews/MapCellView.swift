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
    @State var typeOfTransport: String
    
    @State var isHiddenStop = false
    @Binding var showNavigationDetailStop: Bool
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: typeOfTransport == "Interurban" ? "bus.fill" : "tram.fill")
                    .padding(9)
                    .frame(width: 60, height: 60)
                    .background(typeOfTransport == "Interurban" ? .green : .red)
                    .cornerRadius(9)
                    .font(.title)
                    .padding()
                VStack(alignment: .leading, spacing: 5){
                    Text(nameStop)
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.leading)
                    Text(numberStop)
                        .font(.system(size: 10, weight: .regular, design: .rounded))
                        .foregroundColor(typeOfTransport == "Interurban" ? .green : .red)
                    WrapView(items: linesStop.replacingOccurrences(of: ",", with: "").components(separatedBy: " "))
                }
                Spacer()
            }
            .padding(8)
            .background(.gray)
            .cornerRadius(10)
            .opacity(isHiddenStop ? 1 : 0)
            .onTapGesture {
                self.showNavigationDetailStop.toggle()
            }.frame(width: 350)

            Image(systemName: typeOfTransport == "Interurban" ? "bus.fill" : "tram.fill")
            .padding(3)
            .frame(width: 30, height: 30)
            .background(typeOfTransport == "Interurban" ? .green : .red)
            .cornerRadius(5)
            .onTapGesture {
                self.isHiddenStop.toggle()
            }
        }
    }
}

struct MapCellView_Previews: PreviewProvider {
    static var previews: some View {
        MapCellView(nameStop: "Satolina", numberStop: "11282", linesStop: "628, 625, 621, 624, 623, 627, 620, 626", typeOfTransport: "Interurban", isHiddenStop: true, showNavigationDetailStop: .constant(false))
    }
}
