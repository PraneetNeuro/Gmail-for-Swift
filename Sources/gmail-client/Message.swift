//
//  Message.swift
//  gmail-client
//
//  Created by Praneet S on 09/04/21.
//

import Foundation

struct Header {
    let name: String
    let value: String
}

struct MessagePartBody {
    let attachmentId: String
    let size: Int
    let data: String
}

struct MessagePart {
    let partId: String
    let mimeType: String
    let filename: String
    let headers: [Header]
    let body: MessagePartBody
    let parts: [MessagePart]
}

struct Message {
    let id: String
    let threadId: String
    let labelIds: [String]
    let snippet: String
    let historyId: String
    let internalDate: String
    let payload: MessagePart
    let sizeEstimate: Int
    let raw: String
}
