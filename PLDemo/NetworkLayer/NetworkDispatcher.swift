//
//  NetworkDispatcher.swift
//  PLDemo
//
//  Created by Aisha on 6/10/18.
//  Copyright © 2018 Aisha. All rights reserved.
//
import Foundation
public protocol NetworkDispatcher {
    func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void)
}
