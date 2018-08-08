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
    
    func myview() -> UIView{
        
        let rectbtn = CGRect(x: 0, y: 0, width: 120, height: 120)
        let button = UIButton(frame: rectbtn)
      
        button.backgroundColor = UIColor.darkGray
        
        let rect = CGRect(x: 0, y: 0, width: 120, height: 120)
        let smallview = UIView(frame: rect)
        smallview.backgroundColor = UIColor.blue

        
        let stackView = UIStackView(frame: rect)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleWidth, .flexibleHeight]
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        smallview.addSubview(button)
        
        return stackView
        
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
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? CustomAnnotationView
        
        if anView == nil {
            
           
            anView = CustomAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
           // anView!.image = UIImage(named:"cab")
            //anView!.canShowCallout = true
            //anView!.detailCalloutAccessoryView = self.myview()
            
            anView!.number = arc4random_uniform(10)
            
        }
        else {
           
            anView!.annotation = annotation
            
        }
        
        return anView

    }
    
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



class CustomAnnotationView: MKAnnotationView {
    
    private let annotationFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
    private let label: UILabel
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        
       // self.label = UILabel(frame: annotationFrame.offsetBy(dx: 0, dy: -6))
        self.label = UILabel(frame: annotationFrame)
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = annotationFrame
        self.label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        self.label.textColor = .white
        self.label.textAlignment = .center
        self.backgroundColor = .clear
        self.addSubview(label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented!")
    }
    
    public var number: UInt32 = 0 {
        didSet {
            self.label.text = String(number)
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.beginPath()
        context.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        context.closePath()

        UIColor.blue.set()
        context.fillPath()
        
 }
}
