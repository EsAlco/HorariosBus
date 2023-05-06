//
//  ImageMapsView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 23/6/22.
//

import SwiftUI

struct ImageMapsView: View {
    
    @State private var scale: CGFloat = 1.0
    @State private var position = CGSize.zero
    
    @GestureState private var offset = CGSize.zero
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("CercaniasMadrid")
                    .resizable()
                    .scaledToFill()
                    .padding()
                    .scaleEffect(scale)
                    .offset(
                        x: position.width + offset.width,
                        y: position.height + offset.height)
                    .gesture(
                        MagnificationGesture()
                            .onChanged{ value in
                                self.scale = value.magnitude
                            }
                            .simultaneously(with: DragGesture())
                            .updating($offset){ (value, state, transaction) in
                                state = value.second?.translation ?? .zero
                            }
                            .onEnded{ (value) in
                                self.position.height += value.second?.translation.height ?? .zero
                                self.position.width += value.second?.translation.width ?? .zero
                            }
                    )
                CloseButtonView()
            }
        }
        
        .navigationBarHidden(true)
    }
}

struct ImageMapsView_Previews: PreviewProvider {
    static var previews: some View {
        ImageMapsView()
    }
}
