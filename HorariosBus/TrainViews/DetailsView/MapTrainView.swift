//
//  MapTrainView.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 24/6/22.
//

import SwiftUI
import MapKit

struct MapTrainView: View {
    
    @Environment (\.presentationMode) var presentationMode

    @StateObject var locationViewModel = LocationViewModel()
    @State var tracking: MapUserTrackingMode = .follow
    
    @State var isHiddenStop = false
    @State var showNavigationDetailStop = false
    
    @State var locations: [Location] = []
    
    @State private var showingAlertError = false
    @State var isCharged = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Map(coordinateRegion: $locationViewModel.userLocation, showsUserLocation:  true, annotationItems: locations) { location in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.yGeometryStop, longitude: location.xGeometryStop)) {
                        VStack{
                            MapCellView(nameStop: location.nameStop, numberStop: location.numberStop, linesStop: location.linesStop, typeOfTransport: location.typeOfTransport, isHiddenStop: isHiddenStop, showNavigationDetailStop: $showNavigationDetailStop)
                            NavigationLink("", destination: DetailStopTrainView(nameStop: location.nameStop, numberStop: location.numberStop, tariffZoneStop: "", linesStop: "", aliasStop: "", featureStop: false, typeTransport: ""), isActive: $showNavigationDetailStop)
                                .hidden()
                        }
                    }
                }
                .ignoresSafeArea()
                .task {
                    locationViewModel.checkUserAuthorization()
                }
                
                if isCharged {
                    ProgressView()
                        .scaleEffect(2)
                        .progressViewStyle(CircularProgressViewStyle(tint: .redTrain))
                }
            }
            if locationViewModel.userHasLocation {
                Text("Localización aceptada")
                    .bold()
                    .padding(.top, 12)
                Link("Pulsa para cambiar la autorización de Localización", destination: URL(string: UIApplication.openSettingsURLString)!)
                    .padding(32)
            } else {
                Text("Localización NO aceptada")
                    .bold()
                    .background(.white)
                    .padding(.top, 12)
                Link("Pulsa para cambiar la autorización de Localización", destination: URL(string: UIApplication.openSettingsURLString)!)
                    .padding(32)
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "chevron.down.circle")
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
        }
        .alert("Error al cargar las paradas", isPresented: $showingAlertError) {
            Button("OK", role: .cancel){}
        }

        .onAppear{
            self.isCharged.toggle()
            chargedNetworking()
        }
    }
    
    func chargedNetworking() {
        NetworkingProvider.shared.getAllStopsTrain { allStopsTrainResponse in
            self.isCharged.toggle()
            for attributes in allStopsTrainResponse.features{
                locations.append(contentsOf: [Location(nameStop: attributes.nameStop, numberStop: attributes.numberStop, tariffZoneStop: attributes.tariffZoneStop, linesStop: attributes.linesStop, typeOfTransport: "Train", xGeometryStop: attributes.xGeometryStop, yGeometryStop: attributes.yGeometryStop)])
            }
        } failure: { error in
            self.isCharged.toggle()
            self.showingAlertError.toggle()
        }
    }
}

struct MapTrainView_Previews: PreviewProvider {
    static var previews: some View {
        MapTrainView()
    }
}
