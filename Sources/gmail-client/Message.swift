//
//  Message.swift
//  gmail-client
//
//  Created by Praneet S on 09/04/21.
//

import Foundation

struct Header : Codable {
    let name: String?
    let value: String?
}

struct MessagePartBody : Codable {
    let attachmentId: String?
    let size: Int?
    let data: String?
}

struct MessagePart : Codable {
    let partId: String?
    let mimeType: String?
    let filename: String?
    let headers: [Header]?
    let body: MessagePartBody?
    let parts: [MessagePart]?
}

struct Message : Codable {
    let id: String?
    let threadId: String?
    let labelIds: [String]?
    let snippet: String?
    let historyId: String?
    let internalDate: String?
    let payload: MessagePart?
    let sizeEstimate: Int?
    let raw: String?
}

struct MessagesList : Codable {
  let messages: [MessageListInstance]?
  let nextPageToken: String?
  let resultSizeEstimate: Int?
}

struct MessageListInstance : Codable {
    let id: String?
    let threadId: String?
}
