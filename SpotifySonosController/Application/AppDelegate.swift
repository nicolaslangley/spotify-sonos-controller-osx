//
//  AppDelegate.swift
//  SpotifySonosController
//
//  Created by Nicolas Langley on 10/23/14.
//  Copyright (c) 2014 Nicolas Langley. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSUserNotificationCenterDelegate {
    
    @IBOutlet weak var window: NSWindow!
    var statusBar = NSStatusBar.systemStatusBar()
    var statusBarItem: NSStatusItem = NSStatusItem()
    var menu: NSMenu = NSMenu()
    var menuItem: NSMenuItem = NSMenuItem()
    
    override func awakeFromNib() {
        // Add statusBarItem to status bar
        statusBarItem = statusBar.statusItemWithLength(-1)
        statusBarItem.menu = menu
        statusBarItem.title = "SSC"
        
        // Add menuItem to menu
        menuItem.title = "Play"
        menuItem.action = Selector("setWindowVisible:")
        menuItem.keyEquivalent = ""
        menu.addItem(menuItem)
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        // Set up observing of Spotify notifications
        NSUserNotificationCenter.defaultUserNotificationCenter().delegate = self
        // Note: May have to add a suspension behaviour
        NSDistributedNotificationCenter.defaultCenter().addObserver(self,
                                                                    selector: "eventOccured:",
                                                                    name: "com.spotify.client.PlaybackStateChanged",
                                                                    object: nil)
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func eventOccured(notification: NSNotification) {
        var information: NSDictionary = notification.userInfo!
        if information.valueForKey("Player State") as NSString == "Playing" {
            var artist = information.valueForKey("Artist") as NSString
            var album = information.valueForKey("Album") as NSString
            var title = information.valueForKey("Name") as NSString
            var trackID = information.valueForKey("Track ID") as NSString
            println(trackID)
        }
        
    }


}

