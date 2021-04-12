//
//  Message.swift
//  gmail-client
//
//  Created by Praneet S on 09/04/21.
//

import Foundation

public struct Header : Codable {
    let name: String?
    let value: String?
}

public struct MessagePartBody : Codable {
    let attachmentId: String?
    let size: Int?
    let data: String?
}

public struct MessagePart : Codable {
    let partId: String?
    let mimeType: String?
    let filename: String?
    let headers: [Header]?
    let body: MessagePartBody?
    let parts: [MessagePart]?
}

public struct Message : Codable {
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

public struct MessagesList : Codable {
  let messages: [MessageListInstance]?
  let nextPageToken: String?
  let resultSizeEstimate: Int?
}

public struct MessageListInstance : Codable {
    let id: String?
    let threadId: String?
}

public struct UserMessagesBatchModifyBody : Codable {
      let ids: [String]?
      let addLabelIds: [String]?
      let removeLabelIds: [String]?
}

public struct ModifiedMessageBody : Codable {
      let addLabelIds: [String]?
      let removeLabelIds: [String]?
}
