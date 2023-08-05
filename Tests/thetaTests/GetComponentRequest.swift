//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 05/08/23.
//

import XCTest
@testable import Theta
@testable import SwiftyJSON
@testable import Alamofire

final class GetComponentRequestTests: XCTestCase {
    func testDecoding() throws {
        let expectation = self.expectation(description: "Calling getComponent")
        let service = ComponentService(clientToken: ClientToken(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZWYiOiI1NTE1MTU3Ni1jZGFkLTQ2ZGUtYWI3Mi01OGEzNDY1ZjM2NGMiLCJhbm9uX2tleSI6IjE0MzRkZDU5LTAwOWYtNGQ2Zi05OWE5LTQ4N2Y3Yzk1ODZhMCIsImlhdCI6MTY4OTk2MzQzNCwiZXhwIjoxNzIxNTIxMDM0LCJpc3MiOiJodHRwczovL2J1aWxkd2l0aHRoZXRhLmNvbSJ9.q32FmW5YAqzIncjRw0KXBwDr3J12qFumt5DrbEeyTKk"), httpClient: Session())
        service.getComponent(componentName: "Counter View", branchName: nil) { result in
            switch result {
            case .success(let res):
                print("treeNodes: \(res.treeNodes), children: \(res.treeNodes.children)")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected getComponent to succeed, but it failed with error: \(error)")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
