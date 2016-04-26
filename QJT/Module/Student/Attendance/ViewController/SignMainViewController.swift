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
    @IBOutlet weak var repositionBtn: UIButton!
    @IBOutlet weak var signBtn: UIButton!
    @IBOutlet weak var messageBack: UIView!
    
    var locationManager: CLLocationManager?
    var center: CLLocationCoordinate2D?
    var isLoaded = false
    var point: MKPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI显示
        configUI()
        // 设置基本图层
        mapView?.mapType = MKMapType.Standard
        // 初始化定位
        self.initLocationManager()
        self.pleaseWait()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func repositionBtn(sender: AnyObject) {
        isLoaded = false
        mapView.removeAnnotation(point!)
        self.pleaseWait()
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
            self.clearAllNotice()
            
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
            
            point = MKPointAnnotation()
            point!.coordinate = center!
            point!.title = "我的位置"
            mapView.addAnnotation(point!)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let courseView = segue.destinationViewController as! SignCourseViewController
        courseView.lat = String(center!.latitude)
        courseView.long = String(center!.longitude)
    }
}

// MARK: - private method
extension SignMainViewController {
    func configUI() {
        signBtn.layer.borderWidth = 1
        signBtn.layer.borderColor = UIColor.cyanColor().CGColor
        signBtn.layer.cornerRadius = 8
        signBtn.backgroundColor = UIColor.clearColor()
        
        repositionBtn.layer.borderWidth = 1
        repositionBtn.layer.borderColor = UIColor.cyanColor().CGColor
        repositionBtn.layer.cornerRadius = 8
        repositionBtn.backgroundColor = UIColor.clearColor()
        
        messageBack.layer.cornerRadius = 8
        messageBack.alpha = 0.6
    }
}
