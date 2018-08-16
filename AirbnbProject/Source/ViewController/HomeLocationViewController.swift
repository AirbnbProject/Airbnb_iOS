//
//  HomeLocationViewController.swift
//  AirbnbProject
//
//  Created by 엄태형 on 2018. 8. 8..
//  Copyright © 2018년 김승진. All rights reserved.
//

import UIKit
import MapKit
class HomeLocationViewController: UIViewController {
    
    var maps = Array<Double>()
    var locationManager: CLLocationManager?
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self as? MKMapViewDelegate
        locationManager = CLLocationManager()
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: maps[0], longitude: maps[1])
        locationManager!.delegate = self as? CLLocationManagerDelegate
        let region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(maps[0], maps[1]), MKCoordinateSpanMake(0.3, 0.3))
        mapView.setRegion(region, animated: true)
        let center = mapView.centerCoordinate
        let circle = MKCircle(center: CLLocationCoordinate2D(latitude: maps[0], longitude: maps[1]), radius: 10000)
        mapView.add(circle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension HomeLocationViewController: MKMapViewDelegate {
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
