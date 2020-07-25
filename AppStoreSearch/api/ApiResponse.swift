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
    var releaseDate: String
    var primaryGenreName: String
    
    var screenshotUrls: [String]
    var userRatingCount: Int

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        trackId = try container.decodeIfPresent(Int.self, forKey: .trackId) ?? 0
        trackName = try container.decodeIfPresent(String.self, forKey: .trackName) ?? ""
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        primaryGenreName = try container.decodeIfPresent(String.self, forKey: .primaryGenreName) ?? ""

        screenshotUrls = try container.decodeIfPresent([String].self, forKey: .screenshotUrls) ?? []
        userRatingCount = try container.decodeIfPresent(Int.self, forKey: .userRatingCount) ?? 0
    }
}
