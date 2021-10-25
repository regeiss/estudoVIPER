//
//  Post.swift
//  estudoVIPER
//
//  Created by Roberto Edgar Geiss on 30/09/21.
//

import Foundation

public protocol Post
{
    var PostID: PostIdentifier { get }
}

public protocol PostIdentifier
{
    
}

public protocol PostSummary
{
    var id: Int? { get }
    var title: String? { get }
    var body: String? { get }
    var userIdentifier: Int? { get }
}

public protocol PostDetail: PostSummary
{
    var tagline: String? { get }
    var runtime: TimeInterval? { get }
}

public enum PostFilterAttribute
{
    case title
    case body
    case userIdentifier
}

public enum PostSortAttribute
{
    case userIdentifier
    case title
}
