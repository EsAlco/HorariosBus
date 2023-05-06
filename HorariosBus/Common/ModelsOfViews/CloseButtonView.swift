//
//  CloseButtonView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba on 6/5/23.
//

import SwiftUI

struct CloseButtonView: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    @State private var width = UIScreen.main.bounds.width/2
    @State private var height = UIScreen.main.bounds.height/2
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .foregroundColor(Color.buttonsColor)
                .font(.system(.title2))
                .frame(width: 40, height: 40)
                .background(Color.backgrounColor)
                .cornerRadius(25)
        })
        .offset(x: 40-width, y: 100-height)
    }
}

struct CloseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CloseButtonView()
    }
}
