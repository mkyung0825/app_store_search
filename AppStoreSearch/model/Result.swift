//
//  Result.swift
//  AppStoreSearch
//
//  Created by 조미경 on 29/07/2020.
//

import UIKit

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

