//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Anton Kruglov on 08.10.2026.
//

import Foundation

class FeedViewModel {
    private let model = FeedModel()

    var onResult: ((Bool) -> Void)?
    var onEmptyInput: (() -> Void)?

    func checkWord(_ text: String) {
        let cleanedText = text.trimmingCharacters(in: .whitespaces)

        if cleanedText.isEmpty {
            onEmptyInput?()
            return
        } else {
            let isValid = model.check(word: cleanedText)
            onResult?(isValid)
        }
    }
}
