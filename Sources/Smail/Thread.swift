//
//  Thread.swift
//  gmail-client
//
//  Created by Praneet S on 09/04/21.
//

import Foundation

struct Thread : Codable {
    public let id: String?
    public let snippet: String?
    public let historyId: String?
    public let messages: [Message]?
}

struct ThreadList : Codable {
    public let threads: [Thread]?
    public let nextPageToken: String?
    public let resultSizeEstimate: Int?
}

struct ThreadModifyBody : Codable {
    public let addLabelIds: [String]?
    public let removeLabelIds: [String]?
}
