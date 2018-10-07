//
//  Preferences.swift
//  PLDemo
//
//  Created by Aisha on 7/10/18.
//  Copyright © 2018 Aisha. All rights reserved.
//

import Foundation

func getInt(data:String) -> Int?
{
    return Int(data)
}

func randomInt(min: Int, max:Int) -> Int {
    return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}
