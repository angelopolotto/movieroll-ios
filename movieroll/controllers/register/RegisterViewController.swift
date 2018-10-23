//
//  RegisterViewController.swift
//  movieroll
//
//  Created by Angelo Polotto on 13/08/2018.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class RegisterViewController: UIViewController {
    var languages: [LanguageModel]?
    var selectedLanguage: LanguageModel?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var region: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func register(_ sender: Any) {
//        DiscoverRegisterSegue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveLanguages()
        
        //self.showDialoag()
    }
    
    func retrieveLanguages() {
        print("retrieve languages")
        let sv = UIViewController.displaySpinner(onView: self.view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(Urls.Languages, headers: Headers.NoAuth).responseArray {
            (response: DataResponse<[LanguageModel]>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            UIViewController.removeSpinner(spinner: sv)
            switch response.result {
            case .success:
                self.languages = response.result.value ?? []
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showDialoag() {
        let langAlert = UIAlertController(title: "Choose your language",
                                          message: "The language preference to retrieve info about the movies", preferredStyle: .actionSheet)
        for lang in self.languages! {
            langAlert.addAction(UIAlertAction(title: lang.description, style: .default, handler: {
                (UIAlertAction) in
                self.selectedLanguage = lang
                SharedPref.write(key: "selected_language", value: (self.selectedLanguage?.toJSONString())!)
                print(lang)
            }))
        }
        self.present(langAlert, animated: true, completion: nil)
    }
}
