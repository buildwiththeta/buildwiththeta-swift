//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 31/07/23.
//

import XCTest
@testable import Theta

final class FMarginsTests: XCTestCase {
    func testDecoding() throws {
        let jsonString = """
        {
            "m": [10, 20, 30, 40],
            "t": [5, 10, 15, 20],
            "d": [2, 4, 6, 8]
        }
        """
        let jsonData = jsonString.data(using: .utf8)!
        let margins = try JSONDecoder().decode(FMargins.self, from: jsonData)
        XCTAssertEqual(margins.mobile, [10, 20, 30, 40])
        XCTAssertEqual(margins.tablet, [5, 10, 15, 20])
        XCTAssertEqual(margins.desktop, [2, 4, 6, 8])
    }
}
