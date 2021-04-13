//
//  Draft.swift
//  gmail-client
//
//  Created by Praneet S on 09/04/21.
//

import Foundation

public struct Draft : Codable {
    public let id: String?
    public let message: Message?
    public init(id: String?, message: Message) {
        self.id = id
        self.message = message
    }
}

public struct DraftList : Codable {
    public let drafts: [Draft]?
    public let nextPageToken: String?
    public let resultSizeEstimate: Int?
  }
