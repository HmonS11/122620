//
//  Book.swift
//  BookFinderTest
//
//  Created by wizard on 2022/10/22.
//

import Foundation

struct Meta:Codable{
    var isEnd:Bool
    var pageableCount:Int
    var totalCount:Int
    
    enum CodingKeys:String, CodingKey{
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

struct Book:Codable{
    var title:String
    var publisher:String
    var authors:[String]
    var price:Int
    var thumbnail:String
    var url:String
}

struct Result:Codable{
    var meta:Meta
    var documents:[Book]
}
