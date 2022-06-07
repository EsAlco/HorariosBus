//
//  MapView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 4/6/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Environment (\.presentationMode) var presentationMode

    @StateObject var locationViewModel = LocationViewModel()

    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Map(coordinateRegion: $locationViewModel.userLocation, showsUserLocation: true)
                    .ignoresSafeArea()
                    .task {
                        locationViewModel.checkUserAuthorization()
                    }
                if locationViewModel.userHasLocation {
                    RoundedRectangle(cornerRadius: 9)
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                        .offset(y: geometry.size.height * 0.4)
                        .overlay{
                            Text("Localización aceptada")
                                .bold()
                                .background(.white)
                                .padding(.top, 12)
                                .offset(y: geometry.size.width * 0.6)
                            Link("Pulsa para cambiar la autorización de Localización", destination: URL(string: UIApplication.openSettingsURLString)!)
                                .padding(32)
                                .offset(y: geometry.size.width * 0.75)
                        }
                } else {
                    RoundedRectangle(cornerRadius: 9)
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                        .offset(y: geometry.size.height * 0.4)
                        .overlay{
                            Text("Localización NO aceptada")
                                .bold()
                                .background(.white)
                                .padding(.top, 12)
                                .offset(y: geometry.size.width * 0.6)
                            Link("Pulsa para cambiar la autorización de Localización", destination: URL(string: UIApplication.openSettingsURLString)!)
                                .padding(32)
                                .offset(y: geometry.size.width * 0.75)
                        }
                }
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.black)
                }
                .offset(x: geometry.size.width * 0.4, y: geometry.size.height * -0.4)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
