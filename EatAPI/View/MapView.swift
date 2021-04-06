//
//  MapView.swift
//  EatAPI
//
//  Created by Krzysztof Jankowski on 29/03/2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var region: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    @State static var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.55773, longitude: -0.0985708), span: MKCoordinateSpan(latitudeDelta: 0.55, longitudeDelta: 0.55))
    static var previews: some View {
        MapView(region: $region)
    }
}
