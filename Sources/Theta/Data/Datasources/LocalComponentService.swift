//
//  File.swift
//  
//
//  Created by Andrea Buttarelli on 07/08/23.
//

/*
import Foundation
import SwiftyJSON

class LocalComponentService {
    let clientToken: ClientToken
    let preloadFile: PreloadFile
    let cacheExtensionInSeconds: Int
    let isCacheEnabled: Bool

    init(
        clientToken: ClientToken,
        preloadFile: PreloadFile,
        cacheExtensionInSeconds: Int,
        isCacheEnabled: Bool
    ) {
        self.clientToken = clientToken
        self.preloadFile = preloadFile
        self.cacheExtensionInSeconds = cacheExtensionInSeconds
        self.isCacheEnabled = isCacheEnabled
    }

    func getBox() -> UserDefaults {
        return UserDefaults.standard
    }

    func getLocalComponent(componentName: String, branchName: String?) throws -> GetComponentResponse? {
        guard isCacheEnabled else { return nil }

        guard let cachedData = getBox().data(forKey: componentName) else {
            print("Cache doesn't contain \(componentName)")
            return nil
        }

        let json = JSON(cachedData)
        let savedBranchName = json["branch_name"].stringValue

        guard savedBranchName == branchName else { return nil }

        let createdAt = json["created_at"].int64Value
        let now = Date().timeIntervalSince1970
        let diff = now - Double(createdAt)

        if diff > Double(cacheExtensionInSeconds) {
            print("Cache expired")
            return nil
        }

        return try GetComponentResponse(json: json)
    }

    func saveResponse(componentName: String, branchName: String?, componentResponse: GetComponentResponse) throws {
        var json = componentResponse.toJson()
        json["branch_name"] = branchName
        json["created_at"] = Int64(Date().timeIntervalSince1970)
        
        let jsonData = JSON(json)
        getBox().set(jsonData, forKey: componentName)
        print("Component \(componentName) saved in cache")
    }

    func clearCache() {
        getBox().removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        getBox().synchronize()
    }

    func getPreloadedComponent(componentName: String) async throws -> GetComponentResponse {
        let res: JSON
        
        // Check if customJson is available
        if let customJson = preloadFile.customJson {
            res = JSON(customJson)
        } else {
            // Load from the file in the bundle using thetaPreloadFilePath
            if let data = try? Data(contentsOf: URL(fileURLWithPath: thetaPreloadFilePath), options: .mappedIfSafe) {
                res = try JSON(data: data)
            } else {
                throw RuntimeError("Theta preload file not found.")
            }
        }
        
        if let componentData = res[componentName].string, let decompressedData = decompressAndDecrypt(clientToken.token, encryptedBase64: componentData) {
            return GetComponentResponse.init(json: JSON(parseJSON: decompressedData))
        }
        
        throw RuntimeError("Component data corrupted.")
    }
}
*/
