//
//  AppDelegate.swift
//  ATBrowser
//
//  Created by Harshd on 2016-05-10.
//  Copyright © 2016 Hachi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var windows = [UIWindow]()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        NSUserDefaults.standardUserDefaults().registerDefaults(["UserAgent" : "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.94 Safari/537.36"])
        NSUserDefaults.standardUserDefaults().synchronize()
        
        for screen in UIScreen.screens() {
            if window?.screen != screen{
                var viewController: ViewController? = nil
                NSLog("Screen connected")
                // Get a window for it
                viewController = ViewController()
                viewController?.isAppleTV = true
                window = self.createWindowForScreen(screen)
                // Add the view controller to it
                // This view controller does not do anything special, just presents a view that tells us
                // what screen we're on
                self.addViewController(viewController!, toWindow: window!)

            }
        }
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.screenDidConnect(_:)), name: UIScreenDidConnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.screenDidDisconnect(_:)), name: UIScreenDidDisconnectNotification, object: nil)
        
        if let window = window {
            windows.append(window)
        }
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func screenDidConnect(notification: NSNotification) {
        var screen: UIScreen? = nil
        var window: UIWindow!? = nil
        var viewController: ViewController? = nil
        NSLog("Screen connected")
        screen = notification.object as? UIScreen
        // Get a window for it
        viewController = ViewController()
        viewController?.isAppleTV = true
        window = self.createWindowForScreen(screen!)
        // Add the view controller to it
        // This view controller does not do anything special, just presents a view that tells us
        // what screen we're on
        self.addViewController(viewController!, toWindow: window!)
    }
    
    func screenDidDisconnect(notification: NSNotification) {
        var screen: UIScreen? = nil
        NSLog("Screen disconnected")
        screen = notification.object as? UIScreen
        // Find any window attached to this screen, remove it from our window list, and release it.
        for window: UIWindow in windows {
            if window.screen == screen {
                let windowIndex: Int = windows.indexOf(window)!
                self.windows.removeAtIndex(windowIndex)
                // If it wasn't autorelease, you would deallocate it here.
                self.window = nil
            }
        }
        return
    }
    
    func createWindowForScreen(screen: UIScreen) -> UIWindow {
        var window: UIWindow!? = nil
        // Do we already have a window for this screen?
        for forWindow: UIWindow in windows {
            if forWindow.screen == screen {
                window = forWindow
            }
        }
        // Still nil? Create a new one.
        if window == nil {
            window = UIWindow(frame: screen.bounds)
            window!.screen = screen
            self.windows.append(window!)
        }
        return window!
    }
    
    func addViewController(controller: UIViewController, toWindow windowFromFunc: UIWindow) {
        windowFromFunc.rootViewController = controller
        windowFromFunc.hidden = false
    }


}

