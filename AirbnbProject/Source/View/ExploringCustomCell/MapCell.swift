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
    let latLon = [53.127665, 17.972944]
    override func awakeFromNib() {
        super.awakeFromNib()
        mapView.delegate = self as? MKMapViewDelegate
        locationManager = CLLocationManager()
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: latLon[0], longitude: latLon[1])
        locationManager!.delegate = self as? CLLocationManagerDelegate
        
        let center = mapView.centerCoordinate
        let circle = MKCircle(center: CLLocationCoordinate2D(latitude: latLon[0], longitude: latLon[1]), radius: 90000)
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
