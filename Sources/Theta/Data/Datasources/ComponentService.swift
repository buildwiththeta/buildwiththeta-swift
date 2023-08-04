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
    
    func getComponent(componentName: String, branchName: String?, completion: @escaping (Result<GetComponentResponse, Error>) -> Void) {
        let url = "\(AppStrings.baseUrl)\(AppStrings.getComponentPath)"
        var headers: HTTPHeaders = [
            "Authorization": "Bearer \(clientToken.token)",
            "Content-Type": "application/json",
        ]
        
        var body: [String: Any] = [
            "component_name": componentName,
            "branch_name": branchName ?? NSNull(),
            "log": [:],
        ]
        
        httpClient.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let getPageResponse = try GetComponentResponse(json: JSON(value))
                    completion(.success(getPageResponse))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                let message = "Error fetching component, code: \(response.response?.statusCode ?? 0), message: \(response.data)"
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])))
            }
        }
    }
    
    func sendConversionEvent(eventID: String, abTestID: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "\(AppStrings.baseUrl)\(AppStrings.getComponentPath)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(clientToken.token)",
            "Content-Type": "application/json",
        ]
        
        let body: [String: Any] = [
            "event_id": eventID,
            "ab_test_id": abTestID ?? NSNull(),
        ]
        
        httpClient.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).response { response in
            if response.response?.statusCode == 200 {
                completion(.success(()))
            } else {
                let message = "Error sending a conversion event, code: \(response.response?.statusCode ?? 0), message: \(String(describing: response.data))"
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])))
            }
        }
    }
}

