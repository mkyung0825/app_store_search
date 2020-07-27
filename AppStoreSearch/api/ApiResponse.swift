//
//  ApiResponse.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

public typealias ApiCompletion<M : Codable> = (ApiResult<M>) -> Void

public enum ApiResult<M : Codable> {
    case apiSuccess(M)
    case apiFail(ApiError)
    
    /// Returns a `value` if the result is success.
    public var value: M? {
        if case let .apiSuccess(val) = self { return val } else { return nil }
    }
    
    /// Returns an `error` if the result is failure.
    public var error: ApiError? {
        if case let .apiFail(err) = self { return err } else { return nil }
    }
    
    func isSucess() -> Bool {
        return self.value != nil ? true : false
    }
    
    func isFail() -> Bool {
        return self.error != nil ? true : false
    }
}

public struct ApiResponse<M : Codable>: Codable {
    var resultCount: Int?
    var results: M?
    var errorMessage: String?
}

public struct ApiError: Codable {
    var code: String
    var message: String
    
    init(_ errorCode: String, desc: String = "unknown error"){
        code = errorCode
        message = desc
    }
    init(_ error: NSError) {
        code = String(describing: error.code)
        message = error.localizedDescription
    }
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var primaryGenreName: String
    var releaseDate: String
    var artistName: String
    var artworkUrl512: String
    
    var userRatingCount: Int
    var averageUserRating: CGFloat
    var trackContentRating: String
    
    var screenshotUrls: [String]
    
    var description: String
    
    var version: String
    var currentVersionReleaseDate: String
    var releaseNotes: String

    var sellerName: String
    var languageCodesISO2A: [String]
    var fileSizeBytes: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        trackId = try container.decodeIfPresent(Int.self, forKey: .trackId) ?? 0
        trackName = try container.decodeIfPresent(String.self, forKey: .trackName) ?? ""
        primaryGenreName = try container.decodeIfPresent(String.self, forKey: .primaryGenreName) ?? ""
        artistName = try container.decodeIfPresent(String.self, forKey: .artistName) ?? ""
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        artworkUrl512 = try container.decodeIfPresent(String.self, forKey: .artworkUrl512) ?? ""
        
        userRatingCount = try container.decodeIfPresent(Int.self, forKey: .userRatingCount) ?? 0
        averageUserRating = try container.decodeIfPresent(CGFloat.self, forKey: .averageUserRating) ?? 0
        trackContentRating = try container.decodeIfPresent(String.self, forKey: .trackContentRating) ?? ""

        screenshotUrls = try container.decodeIfPresent([String].self, forKey: .screenshotUrls) ?? []
        
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        
        version = try container.decodeIfPresent(String.self, forKey: .version) ?? ""
        currentVersionReleaseDate = try container.decodeIfPresent(String.self, forKey: .currentVersionReleaseDate) ?? ""
        releaseNotes = try container.decodeIfPresent(String.self, forKey: .releaseNotes) ?? ""

        sellerName = try container.decodeIfPresent(String.self, forKey: .sellerName) ?? ""
        languageCodesISO2A = try container.decodeIfPresent([String].self, forKey: .languageCodesISO2A) ?? []
        fileSizeBytes = try container.decodeIfPresent(String.self, forKey: .fileSizeBytes) ?? ""
        
    }
}
