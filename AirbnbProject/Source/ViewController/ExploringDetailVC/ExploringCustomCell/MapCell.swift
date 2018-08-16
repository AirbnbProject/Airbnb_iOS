//
//  MapCell.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 6..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import MapKit

class MapCell: UICollectionViewCell {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager?
    //47.439505, 20.903018
//    let latLon = ["47.439505", "20.903018"]
    var latLon = Array<String>()
    override func awakeFromNib() {
        super.awakeFromNib()
        mapView.delegate = self as? MKMapViewDelegate
    }
    
    func makeMap(lat: Double, lon: Double) {
        locationManager = CLLocationManager()
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        locationManager!.delegate = self as? CLLocationManagerDelegate
        let region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(lat, lon), MKCoordinateSpanMake(0.3, 0.3))
        mapView.setRegion(region, animated: true)
        let center = mapView.centerCoordinate
        let circle = MKCircle(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), radius: 10000)
        mapView.add(circle)
        
    }

}

extension MapCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circle = overlay as? MKCircle {
            let renderer = MKCircleRenderer(circle: circle)
            renderer.strokeColor = UIColor(red: 0/255, green: 153/255, blue: 153/255, alpha: 1.0)
            renderer.lineWidth = 2
            //176,224,230
            let colors = UIColor(red: 176/255, green: 224/255, blue: 230/255, alpha: 0.5)
            renderer.fillColor = UIColor(red: 176/255, green: 224/255, blue: 230/255, alpha: 0.6)
            
            return renderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
}
