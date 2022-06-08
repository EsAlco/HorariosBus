//
//  LocationViewModel.swift
//  HorariosBus
//
//  Created by Esther Alcoceba Gutiérrez de León on 6/6/22.
//

import Foundation
import CoreLocation
import MapKit


final class LocationViewModel: NSObject, ObservableObject {
    private struct DefaultRegion {
        static let latitude = 40.4929200
        static let longitude = -3.8737100
    }
    private struct Span {
        static let delta = 0.0001
    }
    
    private let locationManager: CLLocationManager = .init()
    @Published var userLocation: MKCoordinateRegion = .init()
    @Published var userHasLocation: Bool = false
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        userLocation = .init(center: CLLocationCoordinate2D(latitude: DefaultRegion.latitude, longitude: DefaultRegion.longitude), span: .init(latitudeDelta: Span.delta, longitudeDelta: Span.delta))
    }
    
    func checkUserAuthorization() {
        let status = locationManager.authorizationStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            userHasLocation = true
            break
        case .denied, .notDetermined, .restricted:
            print("User no ha autorizado mostrar su localización")
            userHasLocation = false
        @unknown default:
            print("Unhandled state")
        }
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [(CLLocation)]) {
        guard let location = locations.last else { return }
        
        userLocation = .init(center: location.coordinate,
                             span: .init(latitudeDelta: Span.delta, longitudeDelta: Span.delta))
        userHasLocation = true
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserAuthorization()
    }
}
