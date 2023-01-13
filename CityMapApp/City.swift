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
    
//    static func getCities() -> [City] {
//        guard let path = Bundle.main.path(forResource: "Places", ofType: "plist"), let array = NSArray(contentsOfFile: path) else { return [] }
//
//        var cities = [City]()
//
//        for item in array {
//            let dictionary = item as? [String : Any]
//            let title = dictionary?["title"] as? String
//            let subtitle = dictionary?["description"] as? String
//            let latitude = dictionary?["latitude"] as? Double ?? 0, longitude = dictionary?["longitude"] as? Double ?? 0
//
//            let city = City(title: title, subtitle: subtitle, coordinate: CLLocationCoordinate2DMake(latitude, longitude))
//            cities.append(city)
//        }
//
//        return cities as [City]
//    }
}
