//
//  ActionSheet.swift
//  movieroll
//
//  Created by Angelo Polotto on 18/11/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func displayAction(title: String,
                       message: String,
                       actionData: [Any],
                       actionTitle: (_ index: Int) -> (String),
                       actionSelected: @escaping (_ index: Int) -> () ) {
        let actionSheetAlert = UIAlertController(title: title,
                                          message: message, preferredStyle: .actionSheet)
        
        for index in 0..<actionData.count {
            actionSheetAlert.addAction(
                UIAlertAction(title: actionTitle(index),
                              style: .default,
                              handler: {
                                    (UIAlertAction) in
                                    actionSelected(index)
                                }
                            )
            )
        }
        self.present(actionSheetAlert, animated: true, completion: nil)
    }
}
