//
//  ErrorHandler.swift
//  iOS
//
//  Created by Myo Zaw Oo on 05/08/2020.
//

import Foundation

struct ErrorHandler {
    
    func convertErrorMessage(refNo: String?, error: BaseErrorResponse?) -> String {        
        var message = ""
                
        message.append("Code: \(error?.Code ?? "")")
        message.append("\n")
        message.append("Message: \(error?.Message ?? "")")
        message.append("\n\n")
        
        for error in error?.Details ?? [] {
            message.append("Code: \(error.ErrorCode ?? "")")
            message.append("\n")
            message.append("Description: \(error.ErrorDescription ?? "")")
            message.append("\n\n")
        }
        message.append("KBZRefNo: \(refNo ?? "")")
        
        return message
        
    }
}
