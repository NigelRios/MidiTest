//
//  AppDelegate.swift
//  MidiTest
//
//  Created by Nigel Rios on 6/18/16.
//  Copyright © 2016 Nigel Rios. All rights reserved.
//

import Cocoa
import MIKMIDI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController: MainWindowController?
    

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        // Create a window controller with a XIB file of the same name
        let mainWindowController = MainWindowController()
        
        // Put the window of the window controller on screen
        mainWindowController.showWindow(self)
        
        // Set the property to point to the window controller
        self.mainWindowController = mainWindowController
        
        self.mainWindowController?.available()
        
    }


}

