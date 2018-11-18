//
// Created by Angelo Polotto on 15/10/2018.
// Copyright (c) 2018 Mobify. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, BaseViewContract {
    private var sv: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showProgress() {
        sv = displaySpinner(onView: self.view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideProgress() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if (sv != nil) {
            removeSpinner(spinner: sv!)
        }
    }
    
    func showError(message: String) {
        // https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
        let alert = UIAlertController(title: Strings.shared.value(forKey: "base.error"), message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Strings.shared.value(forKey: "base.ok"), style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessage(message: String) {
        let alert = UIAlertController(title: Strings.shared.value(forKey: "base.info"), message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Strings.shared.value(forKey: "base.ok"), style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
}

class BaseTableViewController: UITableViewController, BaseViewContract {
    private var sv: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showProgress() {
        sv = UIViewController.displaySpinner(onView: self.view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideProgress() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if (sv != nil) {
            UIViewController.removeSpinner(spinner: sv!)
        }
    }
    
    func showError(message: String) {
        // https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift
        let alert = UIAlertController(title: Strings.shared.value(forKey: "base.error"), message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Strings.shared.value(forKey: "base.ok"), style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMessage(message: String) {
        let alert = UIAlertController(title: Strings.shared.value(forKey: "base.info"), message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Strings.shared.value(forKey: "base.ok"), style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
}
