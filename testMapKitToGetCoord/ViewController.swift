//
//  ViewController.swift
//  testMapKitToGetCoord
//
//  Created by osu on 2018/07/09.
//  Copyright © 2018 osu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!

    private var annotations: [(pin: MKPointAnnotation, circle: MKCircle)] = []

    @IBAction func longPressMap(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .ended else {
            return
        }

        if let prev = annotations.first {
            map.removeAnnotation(prev.pin)
            map.remove(prev.circle)
            annotations.removeAll()
        }

        let point = sender.location(in: map)
        let coord = map.convert(point, toCoordinateFrom: map)

        let pin = MKPointAnnotation()
        pin.coordinate = coord
        pin.title = "\(coord.latitude), \(coord.longitude)"
        map.addAnnotation(pin)
        
        let circle = MKCircle(center: coord, radius: 100)
        map.add(circle)
        
        annotations.append((pin: pin, circle: circle))
    }

    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard overlay is MKCircle else {
            return MKOverlayRenderer()
        }
        
        let circleRender = MKCircleRenderer(overlay: overlay)
        circleRender.strokeColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        circleRender.fillColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0.4)
        circleRender.lineWidth = 1
        return circleRender
    }

    override func viewDidAppear(_ animated: Bool) {
        let coord = CLLocationCoordinate2D(latitude: CLLocationDegrees(35.686186), longitude: CLLocationDegrees(139.765556))
        let mkSpan = MKCoordinateSpan(latitudeDelta: CLLocationDegrees(0.004), longitudeDelta: CLLocationDegrees(0.004))
        let mkRegion = MKCoordinateRegion(center: coord, span: mkSpan)
        map.setRegion(mkRegion, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

