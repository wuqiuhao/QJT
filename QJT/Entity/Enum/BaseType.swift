//
//  BaseType.swift
//  QJT
//
//  Created by LZQ on 16/4/17.
//  Copyright © 2016年 Hale. All rights reserved.
//

import Foundation

protocol BaseType {
    func toString() -> String
    func fromString(value : String) -> Int
    func toInt() -> Int
}