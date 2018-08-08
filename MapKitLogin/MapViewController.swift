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
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MyAnnotationView
        
        if anView == nil {
            
           
            anView = MyAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        
            
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


class MyAnnotationView:MKAnnotationView{
    
    private let annotationFrame = CGRect(x: 0, y: 0, width: 80, height: 80)
    private var View:MyView
     private var label: UILabel

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
     
        self.View = UINib(nibName: "MyView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MyView
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        
         super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.frame = annotationFrame
        self.View.frame = annotationFrame.offsetBy(dx: 0, dy: -6)
        self.View.layer.cornerRadius = 10
        self.View.layer.masksToBounds = true
        
        self.View.lbl_title.text = "title"
        self.View.lbl_subtitle.text = "subtitle"
      
        self.label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        self.label.textColor = .white
        self.label.textAlignment = .center
        self.backgroundColor = .clear
        self.View.addSubview(self.label)
        self.addSubview(View)
       
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    override func draw(_ rect: CGRect) {
       

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.beginPath()
        context.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        context.closePath()

        salmon.set()
        context.fillPath()
        
    }
    
}


