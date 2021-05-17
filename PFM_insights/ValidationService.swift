//
//  ValidationService.swift
//  PFM_insights
//
//  Created by Altria on 17/05/21.
//

import Foundation

struct ValidationService {
    func validateVendor (_ vendor:String?) throws -> String {
        guard let vendor = vendor else {throw validationError.invalidValue}
        guard vendor.count >= 1 else { throw validationError.nameTooShort}
        return vendor
    }
    
    func validateAmount (_ amount:Double?) throws -> Double {
        guard let amount = amount else {throw validationError.invalidValue}
        guard amount >= 0 else {throw validationError.amountTooSmall}
        return amount
    }
}
    
    enum validationError: LocalizedError{
        case invalidValue
        case nameTooShort
        case amountTooSmall
        
        var errorString : String? {
            switch self {
            
            case .invalidValue:
                return "Invalid input, please check"
                
            case .nameTooShort:
                return "Vendor name should not be empty"
                
            case .amountTooSmall:
                return "Amount should be greater than zero"
            }
        }
    }
    
    

