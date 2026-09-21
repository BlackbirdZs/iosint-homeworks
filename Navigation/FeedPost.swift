//
//  FeedPost.swift
//  Navigation
//
//  Created by Anton Kruglov on 31.07.2026.
//

import Foundation

struct FeedPost {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
}

extension FeedPost {
    static func make() -> [FeedPost] {
        [
            FeedPost(author: "Shadowheart", description: "I feel bad for stealing that gold...", image: "postersh", likes: 34, views: 45),
            FeedPost(author: "Minthara", description: "I want to use that power somehow, no one can stop me.", image: "postermn", likes: 20, views: 29),
            FeedPost(author: "Mizora", description: "His soul will be mine! And soon others will follow...", image: "postermz", likes: 15, views: 17),
            FeedPost(author: "Karlach", description: "Too many blood on my axe, gotta clean it before we go kill someone else!", image: "posterkl", likes: 5, views: 10),
        ]
    }
}
