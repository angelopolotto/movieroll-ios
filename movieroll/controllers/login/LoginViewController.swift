//
//  LoginViewController.swift
//  movieroll
//
//  Created by Angelo Polotto on 13/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class LoginViewController: UITableViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func login(_ sender: Any) {
//        print("retrieve publicToken")
//        let parameters:Parameters = [
//            "email": self.selectedLanguage!.language ?? "en-US",
//            "password": self.selectedLanguage!.region ?? "US"
//        ]
//        Alamofire.request(Urls.PublicToken, method: .post, parameters: parameters,
//                          encoding: JSONEncoding.default, headers: Headers.NoAuth)
//            .responseJSON { response in
//                switch response.result {
//                case .success:
//                    let jsonResponse = response.result.value as! NSDictionary
//                    if jsonResponse["token"] != nil {
//                        Headers.token = String(describing: jsonResponse["token"]!)
//                        print(Headers.token)
//                    }
//                }
//        }
    }
}
