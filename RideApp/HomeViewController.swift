//
//  HomeViewController.swift
//  RideApp
//
//  Created by Masud Onikeku on 04/06/2023.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var roundView: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var smallView: UIView!
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var backView: UIView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        roundView.layer.cornerRadius = roundView.frame.height / 2
        smallView.layer.cornerRadius = 2
        bigView.layer.cornerRadius = 8
        backView.layer.cornerRadius = 8
        
        locationManager.delegate = self
        mapView.delegate = self
        
        configureLocation()
        configureMapView()
    }
    
    // MARK: - Location and Maps
      
    func configureLocation() {
       
      switch CLLocationManager.authorizationStatus() {
      case .authorizedAlways:
          locationManager.startUpdatingLocation()
          locationManager.desiredAccuracy = kCLLocationAccuracyBest
          configureMapView()
          
              
      case .authorizedWhenInUse:
          locationManager.requestAlwaysAuthorization()
          locationManager.startUpdatingLocation()
          locationManager.desiredAccuracy = kCLLocationAccuracyBest
          configureMapView()
          
          
      case .denied, .restricted:
          locationManager.requestWhenInUseAuthorization()
      case .notDetermined:
          locationManager.requestWhenInUseAuthorization()
      default:
          break
      }
    }
      
      func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
          if status == .authorizedWhenInUse {
              locationManager.requestAlwaysAuthorization()
              locationManager.startUpdatingLocation()
              locationManager.desiredAccuracy = kCLLocationAccuracyBest
              configureMapView()
              
              
          }else if status == .authorizedAlways {
              
              locationManager.startUpdatingLocation()
              locationManager.desiredAccuracy = kCLLocationAccuracyBest
              configureMapView()
              
          }
      }
      
      func configureMapView () {
          
          mapView.mapType = .standard
          mapView.userLocation.title = "Your location"
          mapView.showsUserLocation = true
          let cordinate = (locationManager.location?.coordinate)
          if let cord = cordinate {
              
              mapView.setRegion(MKCoordinateRegion(center: cord, latitudinalMeters: 0.1, longitudinalMeters: 0.1), animated: true)
          }else {
              
              self.showAlert(message: "Ride App could not get your current Location, please review your location settings")
          }
          
          //mCurrentLocation = mapView.userLocation.location!
          mapView.setUserTrackingMode(.follow, animated: true)
          
          //mSocket.emit("eventName", locationManager)
          /*let pin = MKPointAnnotation()
          pin.coordinate = CLLocationCoordinate2D(latitude: 7.7796, longitude: 5.3155)
          mapView.addAnnotation(pin)*/
          
          
          /*let cordinate = mapView.userLocation.coordinate
          mapView.setRegion(MKCoordinateRegion(center: cordinate, latitudinalMeters: 0.1, longitudinalMeters: 0.1), animated: true)
          let pin = MKPointAnnotation()
          pin.title = "Your Location"
          mapView.addAnnotation(pin)*/
      }
      
      
      
      func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
          
          if annotation.isEqual(mapView.userLocation) {
              
              
              let annotationView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: "annotationView")
              annotationView.canShowCallout = true
              //annotationView.image = UIImage(named: "output-onlinepngtools2")
              return annotationView
          }else {
              let annotationView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: "annotationView2")
              //annotationView.canShowCallout = true
              //annotationView.image = UIImage(named: "output-onlinepngtools")
              return annotationView
          }
          //return nil
      }
      
    

}
