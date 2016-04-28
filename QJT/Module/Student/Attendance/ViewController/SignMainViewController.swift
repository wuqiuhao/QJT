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

class SignMainViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var repositionBtn: UIButton!
    @IBOutlet weak var signBtn: UIButton!
    @IBOutlet weak var messageBack: UIView!
    
    var locationManager: CLLocationManager?
    var center: CLLocationCoordinate2D?
    var isPlease = false
    var point: MKPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let courseView = segue.destinationViewController as! SignCourseViewController
        courseView.lat = center!.latitude
        courseView.long = center!.longitude
    }
}

// MARK: - private method
extension SignMainViewController {
    @IBAction func repositionBtn(sender: AnyObject) {
        mapView.removeAnnotation(point!)
        startUpdatingLocation()
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        // 移动10米重新定位
        locationManager!.distanceFilter = kCLLocationAccuracyNearestTenMeters
        // 定位精度
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.requestWhenInUseAuthorization()
    }
    
    func configUI() {
        navigationItem.title = "学生签到"
        signBtn.layer.cornerRadius = 5
        signBtn.backgroundColor = UIColor.qjtTintColor()
        signBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)

        repositionBtn.layer.cornerRadius = 5
        repositionBtn.backgroundColor = UIColor.qjtTintColor()
        repositionBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        messageBack.layer.cornerRadius = 8
        messageBack.alpha = 0.6
        view.bringSubviewToFront(messageBack)
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
extension SignMainViewController: CLLocationManagerDelegate {
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
        latLabel.text = "纬度：\(center!.latitude)"
        longLabel.text = "经度：\(center!.longitude)"
        
        point = MKPointAnnotation()
        point!.coordinate = center!
        point!.title = "我的位置"
        mapView.addAnnotation(point!)
        manager.stopUpdatingLocation()
    }
    
    //错误处理
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
    }
}

extension SignMainViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        startUpdatingLocation()
    }
}
