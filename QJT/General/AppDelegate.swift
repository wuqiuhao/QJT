//
//  AppDelegate.swift
//  QJT
//
//  Created by wuqiuhao on 16/3/28.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appKey = "8d0ad725b58842d39a90aa77"
    let channel = "App Store"
    let isProduction = false

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window?.backgroundColor = UIColor.whiteColor()
        ThemeConfig.configUI()
        
        
        if UserConfig.isLogined() {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainTabBarController
            if let userID = UserConfig.studentSetting()?.userID where userID.characters.count != 0 {
                vc.userType = UserConfig.studentSetting()!.userType
            } else if let userID = UserConfig.teacherSetting()?.userID where userID.characters.count != 0 {
                vc.userType = UserConfig.teacherSetting()!.userType
            }
            window?.rootViewController = vc
        } else {
            window?.rootViewController = UIStoryboard(name: "RegLogin", bundle: nil).instantiateInitialViewController()
        }
        
        registerJPush(launchOptions)
        
        receiveJPushRigsterNotice()
        
        return true
    }
}

// MARK: - private Method
extension AppDelegate {
    
    func registerJPush(launchOptions: [NSObject: AnyObject]?) {
        // 注册极光推送
        let types = UIUserNotificationType.Badge.rawValue | UIUserNotificationType.Sound.rawValue | UIUserNotificationType.Alert.rawValue
        JPUSHService.registerForRemoteNotificationTypes(types, categories: nil)
        JPUSHService.setupWithOption(launchOptions, appKey: appKey, channel: channel, apsForProduction: isProduction)
    }
    
    // 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
    func application(application: UIApplication , didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings ) {
        application.registerForRemoteNotifications()
    }
    
    // 远程推送通知 注册成功
    func application(application: UIApplication , didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData ) {
        //debugPrint("Success To Register For Remote Notifications! Device Token:\(deviceToken.description)")
        JPUSHService.registerDeviceToken(deviceToken)
        print("JPUSH - registerID:\(JPUSHService.registrationID())")
    }
    
    // 远程推送通知 注册失败
    func application(application: UIApplication ,didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        debugPrint("Did Fail To Register For Remote Notifications With Error:\(error)")
    }
    
    func application(application: UIApplication , didReceiveRemoteNotification userInfo: [ NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void ) {
        
        
    }
    
    func applicationDidEnterBackground(application : UIApplication) {
        JPUSHService.resetBadge()
    }
    
    func applicationWillEnterForeground(application : UIApplication) {
        JPUSHService.resetBadge()
    }
    
    func receiveJPushRigsterNotice() {

    }

    
}
