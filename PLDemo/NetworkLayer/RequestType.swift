//
//  RequestType.swift
//  PLDemo
//
//  Created by Aisha on 6/10/18.
//  Copyright © 2018 Aisha. All rights reserved.
//

public protocol RequestType {
    associatedtype ResponseType: Codable
    var data: RequestData { get }
}
