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
    
    @State var isHiddenStop = false
    
    @State var locations: [Location] = []
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                ZStack{
                    Map(coordinateRegion: $locationViewModel.userLocation, showsUserLocation: true, annotationItems: locations) { location in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.yGeometryStop, longitude: location.xGeometryStop)) {
                            ZStack{
                                Image(systemName: "bus.fill")
                                .padding(3)
                                .background(.green)
                                .cornerRadius(5)
                                .onTapGesture {
                                    self.isHiddenStop.toggle()
                                }
    //                            .overlay {
    //                                if isHiddenStop{
    //                                    MapCellView(nameStop: "LALAL", numberStop: selectLocation.name, linesStop: "628")
    //                                        .offset(y: -60)
    //                                }
    //                            }
                            }
                        }
                    }
    //                    .ignoresSafeArea()
    //                    .task {
    //                        locationViewModel.checkUserAuthorization()
    //                    }
    //
    //                if locationViewModel.userHasLocation {
    //                    RoundedRectangle(cornerRadius: 9)
    //                        .foregroundColor(.white)
    //                        .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
    //                        .offset(y: geometry.size.height * 0.4)
    //                        .overlay{
    //                            Text("Localización aceptada")
    //                                .bold()
    //                                .background(.white)
    //                                .padding(.top, 12)
    //                                .offset(y: geometry.size.width * 0.6)
    //                            Link("Pulsa para cambiar la autorización de Localización", destination: URL(string: UIApplication.openSettingsURLString)!)
    //                                .padding(32)
    //                                .offset(y: geometry.size.width * 0.75)
    //                        }
    //                } else {
    //                    RoundedRectangle(cornerRadius: 9)
    //                        .foregroundColor(.white)
    //                        .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
    //                        .offset(y: geometry.size.height * 0.4)
    //                        .overlay{
    //                            Text("Localización NO aceptada")
    //                                .bold()
    //                                .background(.white)
    //                                .padding(.top, 12)
    //                                .offset(y: geometry.size.width * 0.6)
    //                            Link("Pulsa para cambiar la autorización de Localización", destination: URL(string: UIApplication.openSettingsURLString)!)
    //                                .padding(32)
    //                                .offset(y: geometry.size.width * 0.75)
    //                        }
    //                }

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
        .onAppear{
            NetworkingProvider.shared.getAllStops { allStopsResponse in
                for attributes in allStopsResponse.features{
                    locations.append(contentsOf: [Location(nameStop: attributes.nameStop ?? "", numberStop: attributes.numberStop ?? "", linesStop: attributes.linesStop ?? "", xGeometryStop: attributes.xGeometryStop ?? 0.0, yGeometryStop: attributes.yGeometryStop ?? 0.0)])
                }
                print(allStopsResponse)
            } failure: { error in
                print(error!)
               // self.showingAlert.toggle()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(locations: [Location(nameStop: "", numberStop: "", linesStop: "", xGeometryStop: 0.0, yGeometryStop: 0.0)])
    }
}


