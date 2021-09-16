//
//  wechatCloneApp.swift
//  wechatClone
//
//  Created by Yilei Huang on 2021-09-15.
//

import SwiftUI
import Firebase
@main
struct wechatCloneApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("log_status") var log_Status = false
    var body: some Scene {
        WindowGroup {
            if log_Status{
                homeView()
            }else{
                ContentView()
            }

        }
    }
}


class AppDelegate:NSObject, UIApplicationDelegate{

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }

}
