//
//  ViewController.swift
//  CityMapApp
//
//  Created by Ann Robles on 1/12/23.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!

    var locationManager = CLLocationManager()
    var destinationCount = 0
    var destination: CLLocationCoordinate2D!
    var cities = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        map.isZoomEnabled = false
        map.showsUserLocation = false
        map.delegate = self
        
        guard let currentLocation = locationManager.location else { return }
        let coordinateRegion = MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        map.setRegion(coordinateRegion, animated: true)
        
        addDoubleTap()
    }
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin))
        doubleTap.numberOfTapsRequired = 2
        map.addGestureRecognizer(doubleTap)
    }

    @objc func dropPin(sender: UITapGestureRecognizer) {
        
        let touchPoint = sender.location(in: map)
        let coordinate = map.convert(touchPoint, toCoordinateFrom: map)
        let annotation = MKPointAnnotation()
        
        destinationCount += 1
        
        if destinationCount <= 3 {
            annotation.title = "Destination \(destinationCount)"
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
            
            let city = City(title: "Destination \(destinationCount)", subtitle: "Destination \(destinationCount)", coordinate: CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude))
           cities.append(city)
        }
        
        if (destinationCount == 3) {
            cities.append(cities[0])
            addPolyline()
            addPolygon()
        }

        destination = coordinate

    }
    
    func addPolyline() {
        let coordinates = cities.map {$0.coordinate}
        let polyline = MKPolyline(coordinates: coordinates, count: coordinates.count)
        map.addOverlay(polyline)
    }
    
    func addPolygon() {
        let coordinates = cities.map {$0.coordinate}
        let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
        map.addOverlay(polygon)
    }
    
//   func drawRoute() {
//        map.removeOverlays(map.overlays)
//
//        let sourcePlaceMark = MKPlacemark(coordinate: locationManager.location!.coordinate)
//        let destinationPlaceMark = MKPlacemark(coordinate: destination)
//
//        // request a direction
//        let directionRequest = MKDirections.Request()
//
//        // assign the source and destination properties of the request
//        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
//        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
//
//        // transportation type
//        directionRequest.transportType = .automobile
//
//        // calculate the direction
//        let directions = MKDirections(request: directionRequest)
//        directions.calculate { (response, error) in
//            guard let directionResponse = response else {return}
//            // create the route
//            let route = directionResponse.routes[0]
//            // drawing a polyline
//            self.map.addOverlay(route.polyline, level: .aboveRoads)
//
//            // define the bounding map rect
//            let rect = route.polyline.boundingMapRect
//            self.map.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
//
////            self.map.setRegion(MKCoordinateRegion(rect), animated: true)
//        }
//    }
    
    
//    func calculateDistance(mobileLocationX:Double,
//                           mobileLocationY:Double,
//                           DestinationX:Double,
//                           DestinationY:Double) -> Double
//    {
//
//        let coordinate₀ = CLLocation(latitude: mobileLocationX, longitude: mobileLocationY)
//        let coordinate₁ = CLLocation(latitude: DestinationX, longitude:  DestinationY)
//
//        let distanceInMeters = coordinate₀.distance(from: coordinate₁)
//
//        return distanceInMeters
//    }

}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let rendrer = MKPolylineRenderer(overlay: overlay)
            rendrer.strokeColor = UIColor.systemGreen
            rendrer.lineWidth = 3
            return rendrer
        } else if overlay is MKPolygon {
            let rendrer = MKPolygonRenderer(overlay: overlay)
            rendrer.fillColor = UIColor.red.withAlphaComponent(0.5)
            rendrer.strokeColor = UIColor.systemGreen
            rendrer.lineWidth = 2
            return rendrer
        }
        return MKOverlayRenderer()
    }
}
