//
//  AuthRepository.swift
//  iOS
//
//  Created by Myo Zaw Oo on 05/08/2020.
//

import Foundation
import Combine

struct AuthRepository {
    
    func login(request: ApiRequest.Login.LoginRequest) -> AnyPublisher<(user: User, refNo: String), Error> {
        
        return AuthAPI.login(request: request)
            .map { (loginResponse: LoginResponse) -> (user: User, refNo: String) in
                return (UserMapper.mapLoggedInUser(data: loginResponse.Data!), loginResponse.Data?.RefNo ?? "")
            }.eraseToAnyPublisher()
        
    }
    
    func verifyOtp(request: ApiRequest.Login.OtpVerifyRequest) -> AnyPublisher<String, Error> {
        return AuthAPI.verifyOtp(request: request)
            .map { (otpVerifyResponse: OtpVerifyResponse) -> String in
                return ""
            }
            .eraseToAnyPublisher()
    }
    
    func refreshToken() -> AnyPublisher<Bool, Error> {
        return AuthAPI.refreshToken()            
            .eraseToAnyPublisher()
            
    }
    
    
}
