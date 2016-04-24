//
//  AttendanceMainViewController.swift
//  QJT
//
//  Created by LZQ on 16/4/13.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SignMainViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var signBtn: UIButton!
    @IBOutlet weak var messageBack: UIView!

    var locationManager: CLLocationManager?
    var center: CLLocationCoordinate2D?
    var isLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageBack.layer.cornerRadius = 8
        
        mapView?.mapType = MKMapType.Standard
        self.initLocationManager()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchBtn(sender: AnyObject) {
    }

    func initLocationManager() {
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestWhenInUseAuthorization()
    }
    
    //MARK: CoreLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        center = mapView.userLocation.coordinate
        if center?.latitude != 0 && isLoaded != true {
            
            print("\(center!.latitude):\(center!.longitude)")
            
            isLoaded = true
            mapView?.setCenterCoordinate(center!, animated: true)
            //设置地图范围
            let latDelta = 0.01
            let longDelta = 0.01
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            //使用当前位置
            let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center!,span: span)
            //设置显示区域
            mapView!.setRegion(currentRegion, animated: true)
            
            mapView?.showsUserLocation = false
            latLabel.text = "维度：\(center!.latitude)"
            longLabel.text = "经度：\(center!.longitude)"
            
            let point = MKPointAnnotation()
            point.coordinate = center!
            point.title = "我的位置"
            mapView.addAnnotation(point)
        }
    }
    
    //错误处理
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        
    }
    
    //判断是否拥有权限，有，则开始监听位置更新，反之则停止监听
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:locationManager!.startUpdatingLocation()
        mapView?.showsUserLocation = true
        default:
            locationManager!.stopUpdatingLocation()
            mapView?.showsUserLocation = false
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
