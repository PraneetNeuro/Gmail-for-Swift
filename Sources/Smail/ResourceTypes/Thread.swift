//
//  Thread.swift
//  gmail-client
//
//  Created by Praneet S on 09/04/21.
//

import Foundation

public struct MailThread : Codable {
    public let id: String?
    public let snippet: String?
    public let historyId: String?
    public let messages: [Message]?
}

public struct ThreadList : Codable {
    public let threads: [MailThread]?
    public let nextPageToken: String?
    public let resultSizeEstimate: Int?
}

public struct ThreadModifyBody : Codable {
    public let addLabelIds: [String]?
    public let removeLabelIds: [String]?
}
