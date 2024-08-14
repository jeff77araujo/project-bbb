//
//  FeedState.swift
//  Big Bang Burguer
//
//  Created by Jefferson Oliveira de Araujo on 29/07/24.
//

import Foundation

enum FeedState {
    case loading
    case success(FeedResponse)
    case successHighlight(HighlightResponse)
    case error(String)
}
