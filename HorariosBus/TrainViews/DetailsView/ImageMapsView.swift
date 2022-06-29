//
//  ImageMapsView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 23/6/22.
//

import SwiftUI

struct ImageMapsView: View {
    
    @State var scale: CGFloat = 1.0
    
    var body: some View {
        NavigationView{
            Image("CercaniasMadrid")
                .resizable()
                .scaledToFit()
                .padding()
                .scaleEffect(scale)
                .gesture(
                    MagnificationGesture()
                        .onChanged ({ value in
                            scale = value
                        })
                )
            
        }
        
        .navigationBarHidden(true)
    }
}

struct ImageMapsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageMapsView()
    }
}
