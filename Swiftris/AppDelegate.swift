/*
 *  AppDelegate.swift
 *  Swiftris
 *
 *  Created by bearkode on 2014. 6. 12..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet private var window: NSWindow?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.setupMainViewController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {

    }

    // MARK: - private

    private let mainViewController = MainViewController(nibName: "MainViewController", bundle: Bundle.main)

    private func setupMainViewController() {
        let mainView = self.mainViewController.view

        self.window?.contentView.map {
            $0.addSubview(mainView)
            mainView.frame = $0.bounds
        }

        self.window?.makeFirstResponder(mainView)
    }

}
