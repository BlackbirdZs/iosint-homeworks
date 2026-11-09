//
//  VideoPost.swift
//  Navigation
//
//  Created by Anton Kruglov on 09.11.2026.
//

import Foundation

struct VideoPost {
    let title: String
    let url: String
    let image: String
}

extension VideoPost {
    static func make() -> [VideoPost] {
        [
            VideoPost(title: "Video test 1", url: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8", image: "forest"),
            VideoPost(title: "Video test 2", url: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8", image: "space"),
            VideoPost(title: "Video test 3", url: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8", image: "water"),
            VideoPost(title: "Video test 4", url: "https://youtu.be/29XymHesxa0?si=uEveINnBUl5DzM0y", image: "city"),
        ]
    }
}
