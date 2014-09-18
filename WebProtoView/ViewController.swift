//
//  ViewController.swift
//  WebProtoView
//
//  Created by Andy Matuschak on 7/19/14.
//  Copyright (c) 2014 Khan Academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {
	@IBOutlet var webView: UIWebView?

	let URLKey = "URL"

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

		let tapGesture = UITapGestureRecognizer(target: self, action: "showNavigationAlert")
		tapGesture.numberOfTouchesRequired = 4
		view.addGestureRecognizer(tapGesture)

		NSUserDefaults.standardUserDefaults().registerDefaults([URLKey: "http://Sprout.local:9001"])
		UIApplication.sharedApplication().idleTimerDisabled = true

		showNavigationAlert()
	}

	func showNavigationAlert() {
		let urlString = NSUserDefaults.standardUserDefaults().objectForKey(URLKey) as String!
		let alertView = UIAlertView(title: "Navigate to URL", message: "Tap with four fingers to get this prompt again.", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Navigate")
		alertView.alertViewStyle = .PlainTextInput
		let textField = alertView.textFieldAtIndex(0)! as UITextField
		textField.text = urlString
		alertView.show()
	}

	func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
		let textField = alertView.textFieldAtIndex(0)! as UITextField
		let urlString = textField.text
		NSUserDefaults.standardUserDefaults().setObject(urlString, forKey: URLKey)
		self.loadURLString(urlString)
	}

	func loadURLString(urlString: String) {
		webView!.loadRequest(NSURLRequest(URL: NSURL(string: urlString)))
	}

	override func prefersStatusBarHidden() -> Bool {
		return true;
	}

}

