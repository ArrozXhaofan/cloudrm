//
//  cloudrmApp.swift
//  cloudrm
//
//  Created by Jean Laura on 11/01/25.
//

import SwiftUI
import SwiftData
import FirebaseCore

@main
struct cloudrmApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            MainAppView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
