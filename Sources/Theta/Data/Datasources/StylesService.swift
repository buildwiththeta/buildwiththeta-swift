//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 02/08/23.
//

import Foundation
import Alamofire
import SwiftyJSON

class StylesService {
    let clientToken: ClientToken
    let httpClient: Session
        
    init(clientToken: ClientToken, httpClient: Session) {
        self.clientToken = clientToken
        self.httpClient = httpClient
    }
    
    func fetch() throws -> GetStylesResponse {
        let url = "\(AppStrings.baseUrl)\(AppStrings.getStylesPath)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(clientToken.token)",
            "Content-Type": "application/json",
        ]
        
        let body: [String: Any] = [
            "log": [:],
        ]
        
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<GetStylesResponse, Error>!
        
        httpClient.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let getStylesResponse = try GetStylesResponse(json: JSON(value))
                    result = .success(getStylesResponse)
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
}
