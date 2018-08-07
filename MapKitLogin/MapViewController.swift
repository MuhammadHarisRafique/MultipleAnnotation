//
//  MapViewController.swift
//  MapKitLogin
//
//  Created by Higher Visibility on 06/08/2018.
//  Copyright © 2018 Higher Visibility. All rights reserved.
//

import UIKit
import MapKit

struct Position {
    
    var lattitude:Double
    var longitude:Double
    
}
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var polyline:MKPolyline!{
        
        didSet{
           
             let padding = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
            self.mapView.setVisibleMapRect(polyline.boundingMapRect, edgePadding: padding, animated: true)
            
        }
        
    }
    
    var points:[Position] = [
        
                             Position(lattitude: 36.702910, longitude: -119.236212),
                             Position(lattitude: 36.701997, longitude: -119.236554),
                             Position(lattitude: 36.697777, longitude: -119.234878),
                             Position(lattitude: 36.695167,longitude:  -119.243876),
                             Position(lattitude: 36.695399,longitude:  -119.243399),
                             Position(lattitude: 36.695198,longitude:  -119.2438198),
                             Position(lattitude: 36.695158,longitude:  -119.243858),
                             Position(lattitude: 36.695100,longitude:  -119.243800),
                             Position(lattitude: 36.695120,longitude:  -119.243920),
                             Position(lattitude: 36.695019,longitude:  -119.243700)
        
    ]
    
    var annotionArray:[MKPointAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        for pos in points{
            
            let anotation = MKPointAnnotation()
            let point = CLLocationCoordinate2D(latitude: pos.lattitude, longitude: pos.longitude)
            anotation.coordinate = point
            self.annotionArray.append(anotation)
         
        }
        
       self.mapView.addAnnotations(self.annotionArray)
        
       let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: points[0].lattitude, longitude: points[0].longitude), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        
        self.mapView.setRegion(region, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var cooridinate:[CLLocationCoordinate2D] = []
        
        for verticis in points{
            
            let pos = CLLocationCoordinate2D(latitude: verticis.lattitude, longitude: verticis.longitude)
            cooridinate.append(pos)
            
            
        }
        
         let polyline = MKPolyline(coordinates: &cooridinate, count: cooridinate.count)
    
         self.mapView.add(polyline)
        
    }

}


extension MapViewController:MKMapViewDelegate{
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.clear
            renderer.lineWidth = 0.5
            self.polyline = renderer.polyline
            return renderer
            
        }
        
      return MKOverlayRenderer()
        
    }

}
