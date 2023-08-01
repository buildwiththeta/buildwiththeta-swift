//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 31/07/23.
//

import XCTest
@testable import Theta

final class FSizesTests: XCTestCase {
    func testDecoding() throws {
        let jsonString = """
        {
            "s": "100",
            "t": "150",
            "d": "100",
        }
        """
        let jsonData = jsonString.data(using: .utf8)!
        let sizes = try JSONDecoder().decode(FSize.self, from: jsonData)
        XCTAssertEqual(sizes.mobile, "100")
        XCTAssertEqual(sizes.tablet, "150")
        XCTAssertEqual(sizes.desktop, "100")
    }
}
