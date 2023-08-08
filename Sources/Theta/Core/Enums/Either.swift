//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 07/08/23.
//

import Foundation

enum Either<L, R> {
    case left(L)
    case right(R)
}

