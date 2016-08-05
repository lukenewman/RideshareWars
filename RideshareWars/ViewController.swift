//
//  ViewController.swift
//  RideshareWars
//
//  Created by Luke Newman on 8/2/16.
//  Copyright © 2016 Luke Newman. All rights reserved.
//

import UIKit
import CoreLocation
import Freddy

class ViewController: UIViewController {

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        switch CLLocationManager.authorizationStatus() {
        case .NotDetermined:
            print("requesting")
            locationManager.requestWhenInUseAuthorization()
            setupLocationManager()
        case .Denied, .Restricted:
            print("denied or restricted, should alert user")
        default:
            print("authorized")
            setupLocationManager()
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
    }

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        let coordinate = newLocation.coordinate
        let latitude = Float(coordinate.latitude)
        let longitude = Float(coordinate.longitude)
        
        print("\(latitude), \(longitude)")
        
        LyftAPI.request(.GetCost(latitude, longitude)) { response in
            
            print("response data: \(response.data)")
            
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
//                    self.comments = try json.array("comments").map(Comment.init)
                    print(json)
                    
                } catch JSON.Error.IndexOutOfBounds(let badIndex) {
                    print("Index out of bounds: \(badIndex)")
                } catch JSON.Error.KeyNotFound(let badKey) {
                    print("Key not found: \(badKey)")
                } catch JSON.Error.UnexpectedSubscript(let badSubscript) {
                    print("Unexpected subscript: \(badSubscript)")
                } catch JSON.Error.ValueNotConvertible(let badValue) {
                    print("Value not convertible: \(badValue)")
                } catch {
                    print("Unknown error")
                }
            }
        }
    }
}
