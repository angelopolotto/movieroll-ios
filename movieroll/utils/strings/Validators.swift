//
//  Regex.swift
//  movieroll
//
//  Created by Angelo Polotto on 10/11/18.
//  Copyright © 2018 Mobify. All rights reserved.
//

import Foundation
import Validator

protocol ValidatorsContract {
    func isValidEmail(text: String, onError: (String) -> ()) -> Bool
    func isValidName(text: String, onError: (String) -> ()) -> Bool
    func isValidPassword(text: String, onError: (String) -> ()) -> Bool
}

class Validators: ValidatorsContract {
    static let shared = Validators()
    private init() {}
    
    func isValidEmail(text: String, onError: (String) -> ()) -> Bool {
        let rule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: ValidationError(message: Strings.shared.value(forKey: "errors.email")))
        let result = Validator.validate(input: text, rule: rule)
        
        switch result {
        case .valid: return true
        case .invalid(let failures):
            print(failures)
            let error = failures.first as! ValidationError
            onError(error.message)
            return false
        }
    }
    
    func isValidName(text: String, onError: (String) -> ()) -> Bool {
        let rule = ValidationRuleLength(min: 3, error: ValidationError(message: Strings.shared.value(forKey: "errors.name")))
        let result = Validator.validate(input: text, rule: rule)
        
        switch result {
        case .valid: return true
        case .invalid(let failures):
            let error = failures.first as! ValidationError
            onError(error.message)
            return false
        }
    }
    
    func isValidPassword(text: String, onError: (String) -> ()) -> Bool {
        let rule = ValidationRuleLength(min: 6, error: ValidationError(message: Strings.shared.value(forKey: "errors.password")))
        let result = Validator.validate(input: text, rule: rule)
        
        switch result {
        case .valid: return true
        case .invalid(let failures):
            let error = failures.first as! ValidationError
            onError(error.message)
            return false
        }
    }
}

struct ValidationError: Error {
    public let message: String
    public init(message m: String) {
        message = m
    }
}
