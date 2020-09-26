//
//  ApiError.swift
//  Movie DB
//
//  Created by Myo Zaw Oo on 26/09/2020.
//
struct ApiError: Error {
    let errorMessage: String
}


struct TokenExpired: Error {}
