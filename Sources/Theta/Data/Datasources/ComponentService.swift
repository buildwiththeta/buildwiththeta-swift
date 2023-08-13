//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 02/08/23.
//

import Foundation

import Foundation
import SwiftyJSON
import Alamofire

class ComponentService {
    let clientToken: ClientToken
    let httpClient: Session
    
    init(clientToken: ClientToken, httpClient: Session) {
        self.clientToken = clientToken
        self.httpClient = httpClient
    }
    
    func getComponent(componentName: String, branchName: String?) throws -> GetComponentResponse {
        let url = "\(AppStrings.baseUrl)\(AppStrings.getComponentPath)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(clientToken.token)",
            "Content-Type": "application/json",
        ]
        
        let body: [String: Any] = [
            "component_name": componentName,
            "branch_name": branchName ?? NSNull(),
            "log": [:],
        ]
        
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<GetComponentResponse, Error>!
        
        httpClient.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let getPageResponse = try GetComponentResponse(json: JSON(value))
                    result = .success(getPageResponse)
                } catch {
                    result = .failure(error)
                }
            case .failure:
                let message = "Error fetching component, code: \(response.response?.statusCode ?? 0), message: \(response.data)"
                result = .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message]))
            }
            semaphore.signal()
        }
        
        semaphore.wait()
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        case .none:
            throw RuntimeError("none")
        }
    }
    
    func sendConversionEvent(eventID: String, abTestID: String?) throws {
        let url = "\(AppStrings.baseUrl)\(AppStrings.getComponentPath)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(clientToken.token)",
            "Content-Type": "application/json",
        ]
        
        let body: [String: Any] = [
            "event_id": eventID,
            "ab_test_id": abTestID ?? NSNull(),
        ]
        
        let semaphore = DispatchSemaphore(value: 0)
        var errorOccurred: Error?
        
        httpClient.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).response { response in
            if response.response?.statusCode != 200 {
                let message = "Error sending a conversion event, code: \(response.response?.statusCode ?? 0), message: \(String(describing: response.data))"
                errorOccurred = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
            }
            semaphore.signal()
        }
        
        semaphore.wait()
        
        if let error = errorOccurred {
            throw error
        }
    }
}
