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
    @State var tracking: MapUserTrackingMode = .follow
    
    @State var isHiddenStop = false
    @State var showNavigationDetailStop = false
    
    @State var locations: [Location] = []
    
    @State private var showingAlert = false
    @State private var isCharged = false
    
    @State var isMainView: Bool = false
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView{
                VStack{
                    ZStack{
                        Map(coordinateRegion: $locationViewModel.userLocation, showsUserLocation: true, annotationItems: locations) { location in
                            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.yGeometryStop, longitude: location.xGeometryStop)) {
                                VStack{
                                    MapCellView(nameStop: location.nameStop, numberStop: location.numberStop, linesStop: location.linesStop, typeOfTransport: location.typeOfTransport, isHiddenStop: isHiddenStop, showNavigationDetailStop: $showNavigationDetailStop)
                                    NavigationLink("",destination: DetailStopView(nameStop: "", numberStop: location.numberStop, tariffZoneStop: "", linesStop: "", aliasStop: "", featureStop: false), isActive: $showNavigationDetailStop)
                                        .hidden()
                                }
                            }
                        }
                        .ignoresSafeArea()
                        .task {
                            locationViewModel.checkUserAuthorization()
                        }
                        if !isMainView{
                            CloseButtonView()
                        }
                        
                        if isCharged {
                            ProgressView()
                                .scaleEffect(2)
                                .progressViewStyle(CircularProgressViewStyle(tint: .greenBus))
                        }
                    }
                    if !locationViewModel.userHasLocation {
                        Text("Localización NO aceptada")
                            .bold()
                            .background(Color.backgrounColor)
                            .padding(.top, 12)
                        Link("Pulsa para cambiar la autorización de Localización", destination: URL(string: UIApplication.openSettingsURLString)!)
                            .padding(32)
                    }
                }
            }
            .alert("Error al cargar las paradas", isPresented: $showingAlert) {
                Button("OK", role: .cancel){}
            }

            .onAppear{
                self.isCharged.toggle()
                chargedNetworking()
            }
        }
    }
    
    func chargedNetworking() {
        NetworkingProvider.shared.getAllStops { allStopsResponse in
            self.isCharged.toggle()
            for feature in allStopsResponse.features{
                locations.append(contentsOf: [Location(nameStop: feature.attributes?.nameStop ?? "", numberStop: feature.attributes?.numberStop ?? "", tariffZoneStop: feature.attributes?.tariffZoneStop ?? "", linesStop: feature.attributes?.linesStop ?? "", typeOfTransport: "Interurban", xGeometryStop: feature.geometry?.xGeometryStop ?? 0.0, yGeometryStop: feature.geometry?.yGeometryStop ?? 0.0)])
            }
        } failure: { error in
            self.isCharged.toggle()
            self.showingAlert.toggle()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(locations: [Location(nameStop: "", numberStop: "", tariffZoneStop: "", linesStop: "", typeOfTransport: "Interurban", xGeometryStop: 0.0, yGeometryStop: 0.0)], isMainView: false)
    }
}


