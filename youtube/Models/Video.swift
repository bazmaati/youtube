//
//  Video.swift
//  youtube
//
//  Created by Barry Flanigan on 22/06/2020.
//  Copyright © 2020 Barry Flanigan. All rights reserved.
//

import Foundation

struct Video : Decodable {
    
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date() // changed it from a string to a date format so it can read in the decoder
    
    enum CodingKeys: String, CodingKey {
        
        // name all the elements in the struct that we want, and map it perfectly to the json key value
        // if the struc name matches the json perfectly, you don't have to define the enumeration
        
        case snippet // this is the top tree of json we're starting from
        case thumbnails  // tree under snippet where we find nested file high, item mentioned below
        case high // tree under thumbnails where we find nested file thumbail, item as mentioned below
        case resourceId // tree required for videoId
        
        
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        case videoId
        
    }
    
    init (from decoder: Decoder) throws {
            
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        // parse un-nested sells which are already in snippet
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        // parse thumbnails
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        // parse videoId
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
        
        
        
    }
    
}
