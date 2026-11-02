//
//  FeedModel.swift
//  Navigation
//
//  Created by Anton Kruglov on 06.10.2026.
//

import Foundation

class FeedModel {
    private let secretWord: String = "Secret"

    func check(word: String) -> Bool {
        return word == secretWord
    }
}
