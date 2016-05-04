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

class CTAttendanceMainViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var repositionBtn: UIButton!
    @IBOutlet var repointView: UIView!
    
    var locationManager: CLLocationManager?
    var center: CLLocationCoordinate2D?
    var isPlease = false
    var point: MKPointAnnotation?
    var geocoder: CLGeocoder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "考勤", style: .Plain, target: self, action: #selector(SignMainViewController.signItemClicked))
        // 设置UI显示
        configUI()
        // 设置基本图层
        mapView.delegate = self
        mapView?.mapType = MKMapType.Standard
        mapView?.showsUserLocation = true
        // 初始化定位
        self.initLocationManager()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let courseView = segue.destinationViewController as! CLTSignCourseViewController
        courseView.lat = center!.latitude
        courseView.long = center!.longitude
    }
}

// MARK: - private method
extension CTAttendanceMainViewController {
    // 定位
    @IBAction func repositionBtn(sender: AnyObject) {
        if let point = point {
            mapView.removeAnnotation(point)
        }
        startUpdatingLocation()
    }
    
    // 签到
    func signItemClicked() {
        self.performSegueWithIdentifier("cltSignCourseViewController", sender: nil)
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        geocoder = CLGeocoder()
        locationManager!.delegate = self
        // 移动10米重新定位
        locationManager!.distanceFilter = kCLLocationAccuracyNearestTenMeters
        // 定位精度
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestWhenInUseAuthorization()
    }
    
    func configUI() {
        navigationItem.title = "教师考勤"
        repointView.layer.cornerRadius = 4
        repointView.layer.shadowColor = UIColor.grayColor().CGColor
        repointView.layer.shadowOffset = CGSize(width: 2,height: 2)
        repointView.layer.shadowOpacity = 0.5
        repositionBtn.setImageColor(UIColor.qjtTintColor())
        view.bringSubviewToFront(repointView)
    }
    
    /**
     开始定位
     */
    func startUpdatingLocation() {
        locationManager?.startUpdatingLocation()
        self.pleaseWait()
        isPlease = true
    }
}

// MARK: - CoreLocationManagerDelegate
extension CTAttendanceMainViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isPlease {
            isPlease = false
            self.clearAllNotice()
        }
        center = mapView?.userLocation.coordinate
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
        reverseGeoAction()
        manager.stopUpdatingLocation()
    }
    
    //错误处理
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
    }
}

extension CTAttendanceMainViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        startUpdatingLocation()
    }
}

// MARK: - 地址解析
extension CTAttendanceMainViewController {
    // 反地址解析
    func reverseGeoAction() {
        if let longitude = center?.longitude, latitude = center?.latitude {
            let location = CLLocation(latitude: latitude, longitude: longitude)
            geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                var address:String!
                if let error = error {
                    print(error)
                    return
                } else {
                    if let places = placemarks where !places.isEmpty {
                        address = places.first!.name
                    } else {
                        address = "暂无地址信息"
                    }
                }
                self.point = MKPointAnnotation()
                self.point!.coordinate = self.center!
                self.point!.title = "当前位置"
                self.point!.subtitle = address
                self.mapView.addAnnotation(self.point!)
                self.mapView.selectAnnotation(self.point!, animated: true)
            })
        }
    }
}
