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
    
    func fetch(completion: @escaping (Result<GetStylesResponse, Error>) -> Void) {
        let url = "\(AppStrings.baseUrl)\(AppStrings.getStylesPath)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(clientToken.token)",
            "Content-Type": "application/json",
        ]
        
        let body: [String: Any] = [
            "log": [:],
        ]
        
        httpClient.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                do {
                    let stylesResponse = try GetStylesResponse(json: json)
                    completion(.success(stylesResponse))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                let message = "Error fetching component, code: \(response.response?.statusCode ?? 0), message: \(response.data)"
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])))
            }
        }
    }
}
