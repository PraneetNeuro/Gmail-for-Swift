//
//  helpers.swift
//  gmail-client
//
//  Created by Praneet S on 09/04/21.
//

import Foundation

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}

extension Gmail.UsersMessages {
    
    static func decodeToMessageList(data: Data?) -> MessagesList? {
        guard data != nil else { return nil }
        let decoder = JSONDecoder()
        do {
            let resp = try decoder.decode(MessagesList.self, from: data!)
            return resp
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func decodeToMessage(data: Data?) -> Message? {
        guard data != nil else { return nil }
        let decoder = JSONDecoder()
        do {
            let resp = try decoder.decode(Message.self, from: data!)
            return resp
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

}

extension Gmail.UsersThreads {
    
    static func decodeToThread(data: Data?) -> Thread? {
        guard data != nil else { return nil }
        let decoder = JSONDecoder()
        do {
            let resp = try decoder.decode(Thread.self, from: data!)
            return resp
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func decodeToThreadList(data: Data?) -> Thread? {
        guard data != nil else { return nil }
        let decoder = JSONDecoder()
        do {
            let resp = try decoder.decode(ThreadList.self, from: data!)
            return resp
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    
}
