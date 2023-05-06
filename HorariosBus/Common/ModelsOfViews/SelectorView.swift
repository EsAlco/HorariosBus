//
//  SelectorView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 26/4/22.
//

import SwiftUI

struct SelectorView: View {
    
    var image: String
    var color: Color
    
    var body: some View {

        Circle()
            .foregroundColor(color)
            .frame(width: 50, height: 50)
            .overlay(
                Image(systemName: image)
                    .foregroundColor(.black)
            )
    }
}

struct SelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SelectorView(image: "bus.fill", color: .green)
    }
}
