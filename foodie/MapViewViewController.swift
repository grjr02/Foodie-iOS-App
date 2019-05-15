//
//  MapViewViewController.swift
//  foodie
//
//  Created by Gregory Ross on 5/6/19.
//  Copyright © 2019 company. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewViewController: UIViewController, MapProtocol,MKMapViewDelegate,CLLocationManagerDelegate {
    
    private var string:String?
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    func passMapCoordinates(string: String){
        print(string)
        self.string = string
        let search = MKLocalSearch.Request()
        search.naturalLanguageQuery = string

        let active = MKLocalSearch(request: search)

        active.start { (response, error) in
            if response == nil {
                print("error")

            }else{
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)

                let lon = response?.boundingRegion.center.longitude
                guard let lat = response?.boundingRegion.center.latitude else { return }

                let annotation = MKPointAnnotation()
                annotation.title = string
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon!)
                self.mapView.addAnnotation(annotation)

                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon!)
                let span = MKCoordinateSpan(latitudeDelta: 0.05,longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)




            }
        }
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsScale = true
        mapView.showsPointsOfInterest = true
        mapView.showsUserLocation = true
        locationManager.requestWhenInUseAuthorization()
        //locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations[0]
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1,longitudeDelta: 0.1)
        let myLoc: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: myLoc, span: span)
        mapView.setRegion(region, animated: true)

        self.mapView.showsUserLocation = true

        
        
     
    }
    
}
