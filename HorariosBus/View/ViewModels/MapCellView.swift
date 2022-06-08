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
    
    @State var isHiddenStop = false
    @Binding var showNavigationDetailStop: Bool
    
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 65)
                .foregroundColor(isHiddenStop ? .gray : .clear)
                .overlay(
                    HStack{
                        Image(systemName: "bus.fill")
                            .padding(9)
                            .background(.green)
                            .cornerRadius(9)
                            .font(.title3)
                            .padding()
                        VStack(alignment: .leading){
                            Text(nameStop)
                                .font(.system(size: 13, weight: .regular, design: .rounded))
                                .multilineTextAlignment(.leading)
                            Text(numberStop)
                                .font(.system(size: 10, weight: .regular, design: .rounded))
                                .foregroundColor(.green)
                            Text(linesStop)
                                .font(.system(size: 10, weight: .regular, design: .rounded))
                                .padding(5)
                                .background(.green)
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    .padding(4)
                    .opacity(isHiddenStop ? 1 : 0)
                ).onTapGesture {
                    self.showNavigationDetailStop.toggle()
                }

            Image(systemName: "bus.fill")
            .padding(3)
            .background(.green)
            .cornerRadius(5)
            .onTapGesture {
                self.isHiddenStop.toggle()
            }
        }
    }
}

struct MapCellView_Previews: PreviewProvider {
    static var previews: some View {
        MapCellView(nameStop: "Satolina", numberStop: "11282", linesStop: "628", isHiddenStop: true, showNavigationDetailStop: .constant(false))
    }
}
