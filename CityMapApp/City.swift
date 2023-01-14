//
//  City.swift
//  CityMapApp
//
//  Created by Ann Robles on 1/13/23.
//

import Foundation
import MapKit

class City: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
