//
//  Thread.swift
//  gmail-client
//
//  Created by Praneet S on 09/04/21.
//

import Foundation

public struct Thread : Codable {
    let id: String?
    let snippet: String?
    let historyId: String?
    let messages: [Message]?
}

public struct ThreadList : Codable {
    let threads: [Thread]?
    let nextPageToken: String?
    let resultSizeEstimate: Int?
}

public struct ThreadModifyBody : Codable {
      let addLabelIds: [String]?
      let removeLabelIds: [String]?
}
